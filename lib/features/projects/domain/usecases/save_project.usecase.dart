import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';
import 'package:solar_check/features/projects/domain/usecases/create_inspection.usecase.dart';

@injectable
class SaveProjectUseCase {
  final ProjectRepository _projectRepository;
  final CreateInspectionUseCase _createInspection;
  SaveProjectUseCase(
      {required ProjectRepository projectRepository,
      required CreateInspectionUseCase createInspection})
      : _projectRepository = projectRepository,
        _createInspection = createInspection;

  Future<Either<String, Project>> call(Project project) async {
    final savedProject = await _projectRepository.saveProject(project);
    if (savedProject.isLeft()) return Left('El proyecto no fue guardado');

    await _createInspection
        .call(savedProject.getRight().toNullable()!.projectId);
    return savedProject;
  }
}
