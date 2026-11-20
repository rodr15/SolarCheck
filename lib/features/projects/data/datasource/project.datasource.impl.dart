import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/constants/hive_boxes.dart';
import 'package:solar_check/features/projects/data/datasource/project.datasource.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';

@LazySingleton(as: ProjectDataSource)
class ProjectLocalDataSource implements ProjectDataSource {
  final Box<ProjectModel> _projectsBox;

  const ProjectLocalDataSource(@Named(HiveBoxes.projects) this._projectsBox);

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    return _projectsBox.get(id);
  }

  @override
  Future<void> saveProject(ProjectModel project) async {
    await _projectsBox.put(project.projectId, project);
  }

  @override
  Future<List<ProjectModel>> getAllProjects() async {
    return _projectsBox.values.toList();
  }

  @override
  Future<void> deleteProject(String id) async {
    await _projectsBox.delete(id);
  }
}
