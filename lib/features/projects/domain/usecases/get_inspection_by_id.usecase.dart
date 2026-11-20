import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class GetInspectionByProjectUsecase {
  final InspectionRepository _repository;

  GetInspectionByProjectUsecase(this._repository);

  Future<Either<String, Inspection>> call(String projectId) async {
    return _repository.getInspectionByProjectId(projectId);
  }
}
