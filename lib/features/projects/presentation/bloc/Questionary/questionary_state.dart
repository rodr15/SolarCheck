part of 'questionary_bloc.dart';

@freezed
class QuestionaryState with _$QuestionaryState {
  const factory QuestionaryState.initial() = _Initial;
  const factory QuestionaryState.loaded({
    required SectionItem item,
    required int currentIndex,
    required int totalItems,
  }) = _Loaded;
  const factory QuestionaryState.loading() = _Loading;
  const factory QuestionaryState.error(String error) = _Error;
  const factory QuestionaryState.finish() = _Finish;
}
