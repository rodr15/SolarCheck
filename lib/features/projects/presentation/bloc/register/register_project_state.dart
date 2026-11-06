part of 'register_project_bloc.dart';

@freezed
sealed class RegisterProjectState with _$RegisterProjectState, FormzMixin {
  const RegisterProjectState._();
  const factory RegisterProjectState({
    @Default(NameInput.pure()) NameInput name,
    @Default(NameInput.pure('Utility scale')) NameInput type,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _RegisterProjectState;

  @override
  List<FormzInput> get inputs => [name, type];
}
