import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

abstract class InspectionRepository {
  Future<Either<Inspection, String>> getInspection(String inspectionId);
}
