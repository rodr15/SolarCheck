import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/constants/hive_boxes.dart';
import 'package:solar_check/features/projects/data/datasource/inspection.datasource.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';

@Injectable(as: InspectionDataSource)
class InspectionLocalDataSource implements InspectionDataSource {
  final Box<InspectionModel> _inspectionBox;

  InspectionLocalDataSource(@Named(HiveBoxes.inspections) this._inspectionBox);

  @override
  getInspectionById(String id) async {
    final inspection = _inspectionBox.get(id);
    return inspection;
  }

  @override
  Future<void> saveInspection(InspectionModel inspection) async {
    await _inspectionBox.put(inspection.inspectionId, inspection);
  }

  @override
  List<InspectionModel> getInspectionsByProjectId(String projectId) {
    final inspections = _inspectionBox.values
        .cast<InspectionModel>()
        .where((model) => model.projectId == projectId)
        .toList();

    return inspections;
  }
}
