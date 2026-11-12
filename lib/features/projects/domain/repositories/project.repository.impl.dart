import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/datasource/project.datasource.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';

@Injectable(as: ProjectRepository)
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _dataSource;

  ProjectRepositoryImpl({required ProjectDataSource datasource})
      : _dataSource = datasource;

  @override
  Future<Either<Project, String>> getProjectById(String projectId) async {
    return _dataSource.getProjectById(projectId);
  }

  @override
  Future<void> saveProject(Project project) {
    return _dataSource.saveProject(ProjectModel.fromEntity(project));
  }

  @override
  Future<Either<List<Project>, String>> getAllProject() async {
    final result = await _dataSource.getAllProjects();

    return result.mapLeft(
      (models) => models.map((model) => model.toEntity()).toList(),
    );
  }
}
