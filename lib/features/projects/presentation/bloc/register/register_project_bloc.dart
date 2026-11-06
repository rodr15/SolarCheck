import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/formz_inputs/name.input.dart';

part 'register_project_event.dart';
part 'register_project_state.dart';
part 'register_project_bloc.freezed.dart';

@injectable
class RegisterProjectBloc
    extends Bloc<RegisterProjectEvent, RegisterProjectState> {
  RegisterProjectBloc() : super(RegisterProjectState()) {
    on<_NameChanged>(_onNameChanged);
    on<_TypeChanged>(_onTypeChanged);
    on<_FormSubmitted>(_onFormSubmitted);
  }
  void _onNameChanged(_NameChanged event, Emitter<RegisterProjectState> emit) {
    final name = NameInput.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  void _onTypeChanged(_TypeChanged event, Emitter<RegisterProjectState> emit) {
    final type = NameInput.dirty(event.type);
    emit(state.copyWith(type: type));
  }

  void _onFormSubmitted(
    RegisterProjectEvent event,
    Emitter<RegisterProjectState> emit,
  ) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final isValid = Formz.validate([state.name, state.type]);
    if (!isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }
    try {
      /* [ASRF] TODO: Save in the bd */
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
