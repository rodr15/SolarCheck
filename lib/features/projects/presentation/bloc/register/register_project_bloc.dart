import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/formz_inputs/name.input.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/usecases/save_project.usecase.dart';

part 'register_project_bloc.freezed.dart';
part 'register_project_event.dart';
part 'register_project_state.dart';

@injectable
class RegisterProjectBloc
    extends Bloc<RegisterProjectEvent, RegisterProjectState> {
  final SaveProjectUseCase _saveProject;

  RegisterProjectBloc({required SaveProjectUseCase saveProject})
      : _saveProject = saveProject,
        super(RegisterProjectState()) {
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
      final project = Project(name: state.name.value, type: state.type.value);
      _saveProject.call(project);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
