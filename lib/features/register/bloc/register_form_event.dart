part of 'register_form_bloc.dart';

@freezed
sealed class RegisterFormEvent with _$RegisterFormEvent {
  const factory RegisterFormEvent.nameChanged(String name) = _NameChanged;
  const factory RegisterFormEvent.emailChanged(String email) = _EmailChanged;
  const factory RegisterFormEvent.formSubmitted() = _FormSubmitted;
}
