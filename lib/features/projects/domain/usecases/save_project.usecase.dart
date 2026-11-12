import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';

@injectable
class SaveProjectUseCase {
  final ProjectRepository _projectRepository;

  SaveProjectUseCase({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  Future<void> call(Project project) async {
    return _projectRepository.saveProject(project);
  }
}
