part of 'register_project_bloc.dart';

@freezed
class RegisterProjectEvent with _$RegisterProjectEvent {
  const factory RegisterProjectEvent.nameChanged(String name) = _NameChanged;
  const factory RegisterProjectEvent.typeChanged(String type) = _TypeChanged;
  const factory RegisterProjectEvent.formSubmitted() = _FormSubmitted;
}
