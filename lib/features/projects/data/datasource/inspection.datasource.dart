import 'package:solar_check/features/projects/data/models/inspection.model.dart';

abstract class InspectionDataSource {
  InspectionModel? getInspectionById(String id);
  List<InspectionModel> getInspectionsByProjectId(String projectId);
  Future<void> saveInspection(InspectionModel inspection);
}
