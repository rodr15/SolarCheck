import 'package:fpdart/fpdart.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/config/constants/hive_boxes.dart';
import 'package:solar_check/features/projects/data/datasource/inspection.datasource.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';

@Injectable(as: InspectionDataSource)
class InspectionLocalDataSource implements InspectionDataSource {
  final Box _inspectionBox;

  InspectionLocalDataSource(@Named(HiveBoxes.inspections) this._inspectionBox);

  @override
  getInspectionById(String id) async {
    final inspection = await _inspectionBox.get(id) as InspectionModel?;
    if (inspection == null) {
      return Either.right('Error getting the inspection ');
    }
    return Either.left(inspection);
  }
}
