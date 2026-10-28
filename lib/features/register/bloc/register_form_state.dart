part of 'register_form_bloc.dart';

@freezed
sealed class RegisterFormState with _$RegisterFormState, FormzMixin {
  const RegisterFormState._();

  const factory RegisterFormState({
    @Default(NameInput.pure()) NameInput name,
    @Default(EmailInput.pure()) EmailInput email,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _RegisterFormState;

  @override
  List<FormzInput> get inputs => [name, email];
}
