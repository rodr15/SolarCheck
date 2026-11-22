import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.extension.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';
import 'package:solar_check/features/projects/domain/usecases/get_inspection.usecase.dart';
import 'package:solar_check/features/projects/domain/usecases/save_inspection.usecase.dart';

part 'questionary_bloc.freezed.dart';
part 'questionary_event.dart';
part 'questionary_state.dart';

@injectable
class QuestionaryBloc extends Bloc<QuestionaryEvent, QuestionaryState> {
  QuestionaryBloc({
    required GetInspectionUsecase getInspectionUsecase,
    required SaveInspectionUseCase saveInspectionUseCase,
  })  : _saveInspectionUseCase = saveInspectionUseCase,
        _getInspectionUsecase = getInspectionUsecase,
        super(const QuestionaryState.initial()) {
    on<_Started>(_onStarted);
    on<_Next>(_onNext);
    on<_ForceSaveInspection>(_onForceSaveInspection);
  }

  final GetInspectionUsecase _getInspectionUsecase;
  final SaveInspectionUseCase _saveInspectionUseCase;
  late Inspection _inspection;
  List<SectionItem> _items = [];
  int _currentIndex = 0;

  Future<void> _onStarted(
    _Started event,
    Emitter<QuestionaryState> emit,
  ) async {
    emit(const QuestionaryState.loading());

    final result = await _getInspectionUsecase.call(event.inspectionId);

    final inspection = result.fold(
      (error) {
        emit(QuestionaryState.error(error));
        return null;
      },
      (data) => data,
    );

    if (inspection == null) return;

    _inspection = inspection;
    _items = _inspection.inspectionAnswers
        .expand((section) => section.getFlattenItems())
        .toList();

    if (_items.isEmpty) {
      emit(const QuestionaryState.finish());
      return;
    }

    if (event.item != null) {
      final foundIndex = _items.indexOf(event.item!);
      _currentIndex = foundIndex != -1 ? foundIndex : 0;
    } else {
      _currentIndex = 0;
    }

    _emitCurrentItem(emit);
  }

  Future<void> _onNext(
    _Next event,
    Emitter<QuestionaryState> emit,
  ) async {
    if (_items.isEmpty || _currentIndex >= _items.length) {
      await _finishAndSave(emit);
      return;
    }

    final currentItem = _items[_currentIndex];

    final updatedItem = currentItem.copyWith(
      status: event.status,
      comments: event.comments,
    );

    _inspection = _inspection.updateSectionItem(
      previousItem: currentItem,
      updatedItem: updatedItem,
    );

    _items = _inspection.getAllFlattenItems();

    final nextIndex = _currentIndex + 1;
    if (nextIndex < _items.length) {
      _currentIndex = nextIndex;
      _emitCurrentItem(emit);
    } else {
      await _finishAndSave(emit);
    }
  }

  Future<void> _finishAndSave(Emitter<QuestionaryState> emit) async {
    emit(const QuestionaryState.loading());

    await _saveInspectionUseCase.call(_inspection);
    emit(const QuestionaryState.finish());
  }

  Future<void> _onForceSaveInspection(
    _ForceSaveInspection event,
    Emitter<QuestionaryState> emit,
  ) async {
    _finishAndSave(emit);
  }

  void _emitCurrentItem(Emitter<QuestionaryState> emit) {
    emit(
      QuestionaryState.loaded(
        item: _items[_currentIndex],
        currentIndex: _currentIndex,
        totalItems: _items.length,
      ),
    );
  }
}
