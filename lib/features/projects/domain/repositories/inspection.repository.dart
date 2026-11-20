import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

abstract class InspectionRepository {
  Either<String, Inspection> getInspection(String inspectionId);
  Either<String, Inspection> getInspectionByProjectId(String projectId);
  Future<Inspection> createInspection(Inspection inspection);
}
