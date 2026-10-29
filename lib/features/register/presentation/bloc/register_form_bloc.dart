import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/formz_inputs/inputs.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';
import 'package:solar_check/core/user/domain/usecases/save_user.usecase.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';
part 'register_form_bloc.freezed.dart';

@singleton
class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final SaveUserUseCase _saveUserUseCase;

  RegisterFormBloc({required SaveUserUseCase saveRegisterUseCase})
      : _saveUserUseCase = saveRegisterUseCase,
        super(RegisterFormState()) {
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

  void _onFormSubmitted(
    RegisterFormEvent event,
    Emitter<RegisterFormState> emit,
  ) {
    try {
      final UserEntity entity =
          UserEntity(name: state.name.value, email: state.email.value);
      _saveUserUseCase.call(entity);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  bool _isValid() {
    return Formz.validate([state.name, state.email]);
  }
}
