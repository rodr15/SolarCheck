part of 'inspection_bloc.dart';

@freezed
class InspectionEvent with _$InspectionEvent {
  const factory InspectionEvent.started(String projectId) = _Started;
  const factory InspectionEvent.load() = _Load;
}
