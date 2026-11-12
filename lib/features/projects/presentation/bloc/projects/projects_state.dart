part of 'projects_bloc.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = _Initial;
  const factory ProjectsState.loading() = _Loading;
  const factory ProjectsState.loaded(List<Project> projects) = _Loaded;
  const factory ProjectsState.error(String error) = _Error;
}
