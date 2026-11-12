import 'package:hive_ce/hive_ce.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';

part 'project.model.g.dart';

@HiveType(typeId: 3)
class ProjectModel extends Project {
  @HiveField(0)
  final String projectId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  ProjectModel({
    required this.projectId,
    required this.name,
    required this.type,
  }) : super(
          projectId: projectId,
          name: name,
          type: type,
        );

  factory ProjectModel.fromEntity(Project project) {
    return ProjectModel(
      projectId: project.projectId,
      name: project.name,
      type: project.type,
    );
  }

  Project toEntity() {
    return Project(
      projectId: projectId,
      name: name,
      type: type,
    );
  }
}
