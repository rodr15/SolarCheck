import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class GetInspectionUsecase {
  final InspectionRepository _repository;

  GetInspectionUsecase(this._repository);

  Future<Either<Inspection, String>> call(String id) async {
    return await _repository.getInspection(id);
  }
}
