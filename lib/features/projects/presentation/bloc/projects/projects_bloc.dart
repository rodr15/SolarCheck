import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.export.repository.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';
import 'package:solar_check/features/projects/domain/services/file_action.service.dart';

part 'projects_event.dart';
part 'projects_state.dart';
part 'projects_bloc.freezed.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectRepository _repository;
  final InspectionExportRepository _inspectionExportRepository;

  ProjectsBloc({
    required ProjectRepository repository,
    required InspectionExportRepository inspectionExportRepository,
  })  : _inspectionExportRepository = inspectionExportRepository,
        _repository = repository,
        super(_Initial()) {
    on<_Load>(_onLoad);
    on<_Share>(_onShare);
    on<_Download>(_onDownload);
  }

  Future<void> _onLoad(_Load event, Emitter<ProjectsState> emit) async {
    emit(_Loading());
    final projects = await _repository.getAllProjects();

    projects.fold(
      (e) => _Error('No se pudo cargar la BD'),
      (p) => emit(_Loaded(p)),
    );
  }

  Future<void> _onDownload(_Download event, Emitter<ProjectsState> emit) async {
    final inspection = event.project.inspection;
    if (inspection == null) {
      emit(_Error('No se pudo exportar'));
      return;
    }

    final exportInspection =
        await _inspectionExportRepository.export(inspection);
    FileActionService.saveInPhone(
      bytes: exportInspection,
      fileName: event.project.name,
    );
  }

  Future<void> _onShare(_Share event, Emitter<ProjectsState> emit) async {
    final inspection = event.project.inspection;
    if (inspection == null) {
      emit(_Error('No se pudo exportar'));
      return;
    }

    final exportInspection =
        await _inspectionExportRepository.export(inspection);
    FileActionService.shareFile(
      bytes: exportInspection,
      fileName: event.project.name,
    );
  }
}
