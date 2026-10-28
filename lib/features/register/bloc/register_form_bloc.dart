import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/inputs/inputs.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';
part 'register_form_bloc.freezed.dart';

@injectable
class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFormBloc() : super(RegisterFormState()) {
    on<_NameChanged>(_onNameChanged);
    on<_EmailChanged>(_onEmailChanged);
    on<_FormSubmitted>(_onFormSubmitted);
  }

  void _onNameChanged(_NameChanged event, Emitter<RegisterFormState> emit) {
    final name = NameInput.dirty(event.name);

    emit(state.copyWith(name: name));
  }

  void _onEmailChanged(_EmailChanged event, Emitter<RegisterFormState> emit) {
    final email = EmailInput.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  Future<void> _onFormSubmitted(
    RegisterFormEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    final isValid = Formz.validate([state.name, state.email]);
    if (!isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      /* [ASRF] TODO: Save the info in the db */
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
