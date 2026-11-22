import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

abstract class InspectionRepository {
  Future<Either<String, Inspection>> getInspection(String inspectionId,
      {bool forceRefresh = false});
  Future<void> cacheInspection(String projectId, Inspection inspection);
  Either<String, Inspection> getInspectionByProjectId(String projectId);
  Future<Inspection> saveInspection(Inspection inspection);
}
