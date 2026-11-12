import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';

abstract class ProjectRepository {
  Future<void> saveProject(Project project);
  Future<Either<Project, String>> getProjectById(String projectId);
  Future<Either<List<Project>, String>> getAllProject();
}
