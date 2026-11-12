import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';

part 'projects_event.dart';
part 'projects_state.dart';
part 'projects_bloc.freezed.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectRepository _repository;

  ProjectsBloc({required ProjectRepository repository})
      : _repository = repository,
        super(_Initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(_Load event, Emitter<ProjectsState> emit) async {
    final projects = await _repository.getAllProject();

    projects.fold(
        (p) => emit(_Loaded(p)), (e) => _Error('No se pudo cargar la BD'));
  }
}
