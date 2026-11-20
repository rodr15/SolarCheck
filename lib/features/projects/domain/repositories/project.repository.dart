import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';

abstract interface class ProjectRepository {
  Future<Either<String, Project>> getProjectById(String projectId);
  Future<Either<String, Project>> saveProject(Project project);
  Future<Either<String, List<Project>>> getAllProjects();
}
