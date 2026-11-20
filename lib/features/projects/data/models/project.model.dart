import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';

part 'project.model.freezed.dart';
part 'project.model.g.dart';

@freezed
abstract class ProjectModel with _$ProjectModel {
  const ProjectModel._();
  const factory ProjectModel({
    @JsonKey(name: "projectId") required String projectId,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "type") required String type,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Project toEntity() => Project(
        projectId: projectId,
        name: name,
        type: type,
      );

  factory ProjectModel.fromEntity(Project project) => ProjectModel(
        projectId: project.projectId,
        name: project.name,
        type: project.type,
      );
}
