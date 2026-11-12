import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/datasource/inspection.datasource.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@LazySingleton(as: InspectionRepository)
class InspectionRepositoryImpl implements InspectionRepository {
  final InspectionDataSource _inspectionDatasource;

  InspectionRepositoryImpl({
    required InspectionDataSource inspectionDatasource,
  }) : _inspectionDatasource = inspectionDatasource;

  @override
  Future<Either<Inspection, String>> getInspection(String projectId) async {
    return _inspectionDatasource.getInspectionById(projectId);
  }
}
