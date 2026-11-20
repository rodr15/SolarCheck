import 'package:solar_check/features/projects/data/models/project.model.dart';

abstract interface class ProjectDataSource {
  Future<ProjectModel?> getProjectById(String id);
  Future<void> saveProject(ProjectModel project);
  Future<List<ProjectModel>> getAllProjects();
  Future<void> deleteProject(String id);
}
