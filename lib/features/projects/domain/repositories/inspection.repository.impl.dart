import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/datasource/inspection.datasource.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@LazySingleton(as: InspectionRepository)
class InspectionRepositoryImpl implements InspectionRepository {
  final InspectionDataSource _inspectionDatasource;

  InspectionRepositoryImpl({
    required InspectionDataSource inspectionDatasource,
  }) : _inspectionDatasource = inspectionDatasource;

  @override
  Either<String, Inspection> getInspection(String projectId) {
    final inspection = _inspectionDatasource.getInspectionById(projectId);
    if (inspection == null) {
      return Left('No existe una inspeccion con este id');
    }
    return Right(inspection.toEntity());
  }

  @override
  Future<Inspection> createInspection(Inspection inspection) async {
    InspectionModel inspectionModel = InspectionModel.fromEntity(inspection);
    _inspectionDatasource.saveInspection(inspectionModel);

    return inspectionModel.toEntity();
  }

  @override
  Either<String, Inspection> getInspectionByProjectId(String projectId) {
    final inspectionList =
        _inspectionDatasource.getInspectionsByProjectId(projectId);
    if (inspectionList.isEmpty) {
      return Left('No hay ninguna inspeccion en este proyecto');
    }
    return Right(inspectionList.last.toEntity());
  }
}
