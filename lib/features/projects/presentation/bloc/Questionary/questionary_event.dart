part of 'questionary_bloc.dart';

@freezed
class QuestionaryEvent with _$QuestionaryEvent {
  const factory QuestionaryEvent.started(String inspectionId,
      {SectionItem? item}) = _Started;
  const factory QuestionaryEvent.next(
      {@Default(ValidationStatus.pending) ValidationStatus status,
      String? comments}) = _Next;
  const factory QuestionaryEvent.previous() = _Previous;
  const factory QuestionaryEvent.goTo(String title) = _Goto;
  const factory QuestionaryEvent.forceSave() = _ForceSaveInspection;
}
