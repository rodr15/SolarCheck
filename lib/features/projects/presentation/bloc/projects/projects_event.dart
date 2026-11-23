part of 'projects_bloc.dart';

@freezed
class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.load() = _Load;
  const factory ProjectsEvent.share(Project project) = _Share;
  const factory ProjectsEvent.download(Project project) = _Download;
}
