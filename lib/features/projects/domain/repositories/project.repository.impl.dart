import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/datasource/project.datasource.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';

@LazySingleton(as: ProjectRepository)
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _dataSource;

  const ProjectRepositoryImpl({required ProjectDataSource datasource})
      : _dataSource = datasource;

  @override
  Future<Either<String, Project>> getProjectById(String projectId) async {
    try {
      final model = await _dataSource.getProjectById(projectId);
      if (model == null) {
        return const Left('No se encontró el proyecto solicitado');
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left('Error al obtener el proyecto: $e');
    }
  }

  @override
  Future<Either<String, Project>> saveProject(Project project) async {
    try {
      final model = ProjectModel.fromEntity(project);
      await _dataSource.saveProject(model);
      return Right(model.toEntity());
    } catch (e) {
      return Left('Error al guardar el proyecto: $e');
    }
  }

  @override
  Future<Either<String, List<Project>>> getAllProjects() async {
    try {
      final models = await _dataSource.getAllProjects();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left('Error al listar los proyectos: $e');
    }
  }
}
