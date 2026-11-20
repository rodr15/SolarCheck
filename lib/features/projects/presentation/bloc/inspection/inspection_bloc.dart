import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/usecases/get_inspection.usecase.dart';
import 'package:solar_check/features/projects/domain/usecases/get_inspection_by_id.usecase.dart';

part 'inspection_event.dart';
part 'inspection_state.dart';
part 'inspection_bloc.freezed.dart';

@injectable
class InspectionBloc extends Bloc<InspectionEvent, InspectionState> {
  final GetInspectionUsecase _getInspectionUsecase;
  final GetInspectionByProjectUsecase _getInspectionByProjectUseCase;
  InspectionBloc(
      {required GetInspectionUsecase getInspectionUsecase,
      required GetInspectionByProjectUsecase getInspectionByProjectUseCase})
      : _getInspectionByProjectUseCase = getInspectionByProjectUseCase,
        _getInspectionUsecase = getInspectionUsecase,
        super(_Initial()) {
    on<_Started>(load);
  }

  Future<void> load(_Started event, Emitter<InspectionState> emit) async {
    Either<String, Inspection> inspection =
        await _getInspectionByProjectUseCase.call(event.projectId);
    inspection.fold(
      (e) => emit(_Error(e)),
      (i) => emit(_Loaded(i)),
    );
  }
}
