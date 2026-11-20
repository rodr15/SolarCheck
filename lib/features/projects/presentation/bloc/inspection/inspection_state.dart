part of 'inspection_bloc.dart';

@freezed
class InspectionState with _$InspectionState {
  const factory InspectionState.initial() = _Initial;
  const factory InspectionState.loading() = _Loading;
  const factory InspectionState.loaded(Inspection inspection) = _Loaded;
  const factory InspectionState.error(String error) = _Error;
}
