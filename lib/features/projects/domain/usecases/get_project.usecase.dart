import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/project.repository.dart';

@injectable
class GetProjectListUseCase {
  final ProjectRepository _projectRepository;

  GetProjectListUseCase({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  Future<Either<List<Project>, String>> call() {
    return _projectRepository.getAllProject();
  }
}
