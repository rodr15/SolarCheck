import 'package:fpdart/src/either.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/constants/hive_boxes.dart';
import 'package:solar_check/features/projects/data/datasource/project.datasource.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';

@Injectable(as: ProjectDataSource)
class ProjectLocalDataSource implements ProjectDataSource {
  final Box<ProjectModel> _projectsBox;

  ProjectLocalDataSource(@Named(HiveBoxes.projects) this._projectsBox);
  @override
  Future<Either<ProjectModel, String>> getProjectById(String id) async {
    final project = _projectsBox.get(id);
    if (project == null) {
      return Either.right('Error getting the inspection ');
    }
    return Either.left(project);
  }

  @override
  Future<void> saveProject(ProjectModel project) async {
    await _projectsBox.add(project);
  }

  @override
  Future<Either<List<ProjectModel>, String>> getAllProjects() async {
    final projects = _projectsBox.values.toList();
    return Either.left(projects);
  }
}
