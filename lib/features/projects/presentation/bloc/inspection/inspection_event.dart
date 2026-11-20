part of 'inspection_bloc.dart';

@freezed
class InspectionEvent with _$InspectionEvent {
  const factory InspectionEvent.started(String projectId) = _Started;
  const factory InspectionEvent.nextQuestion() = _Next;
  const factory InspectionEvent.previous() = _Previous;
  const factory InspectionEvent.goTo(String cat, String question) = _GoTo;
}
