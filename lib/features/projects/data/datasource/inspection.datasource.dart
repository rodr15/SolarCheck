import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';

abstract class InspectionDataSource {
  Future<Either<InspectionModel, String>> getInspectionById(String id);
}
