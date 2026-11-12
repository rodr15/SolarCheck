part of 'inspection_bloc.dart';

@freezed
class InspectionEvent with _$InspectionEvent {
  const factory InspectionEvent.started() = _Started;
}