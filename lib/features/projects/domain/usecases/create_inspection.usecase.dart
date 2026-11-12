import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class CreateInspectionUseCase {
  CreateInspectionUseCase({required InspectionRepository repository})
      : _repository = repository;
  InspectionRepository _repository;
  Future<void> call(String projectId) async {
    await _repository.createInspection(projectId);
  }
}
