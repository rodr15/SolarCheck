import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/export/inspection.export.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.export.repository.dart';

@Injectable(as: InspectionExportRepository)
class InspectionExportRepositoryImpl extends InspectionExportRepository {
  InspectionExportRepositoryImpl({required InspectionExport exporter})
      : _exporter = exporter;

  final InspectionExport _exporter;

  @override
  Future<Uint8List> export(Inspection inspection) async {
    return await _exporter.export(inspection);
  }
}
