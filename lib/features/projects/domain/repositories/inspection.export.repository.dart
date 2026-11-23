import 'dart:typed_data';

import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

abstract class InspectionExportRepository {
  Future<Uint8List> export(Inspection inspection);
}
