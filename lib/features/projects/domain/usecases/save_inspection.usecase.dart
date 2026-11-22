import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class SaveInspectionUseCase {
  final InspectionRepository _repository;

  SaveInspectionUseCase(this._repository);

  Future<void> call(Inspection inspection) async {
    await _repository.saveInspection(inspection);
  }
}
