import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class GetInspectionUsecase {
  final InspectionRepository _repository;

  GetInspectionUsecase(this._repository);

  Future<Either<String, Inspection>> call(
    String id, {
    bool forceRefresh = false,
  }) async {
    return _repository.getInspection(id, forceRefresh: forceRefresh);
  }
}
