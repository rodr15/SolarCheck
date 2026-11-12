import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';

abstract class ProjectDataSource {
  Future<Either<ProjectModel, String>> getProjectById(String id);
  Future<void> saveProject(ProjectModel project);
  Future<Either<List<ProjectModel>, String>> getAllProjects();
}
