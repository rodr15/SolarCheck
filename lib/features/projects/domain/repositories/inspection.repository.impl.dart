import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/datasource/cache/inspection.cache.dart';
import 'package:solar_check/features/projects/data/datasource/inspection.datasource.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@LazySingleton(as: InspectionRepository)
class InspectionRepositoryImpl implements InspectionRepository {
  final InspectionDataSource _inspectionDatasource;
  final InspectionCache _cache;

  InspectionRepositoryImpl({
    required InspectionDataSource inspectionDatasource,
    required InspectionCache inspectionCache,
  })  : _cache = inspectionCache,
        _inspectionDatasource = inspectionDatasource;

  @override
  Future<Inspection> saveInspection(Inspection inspection) async {
    InspectionModel inspectionModel = InspectionModel.fromEntity(inspection);
    _inspectionDatasource.saveInspection(inspectionModel);
    cacheInspection(inspection.inspectionId, inspection);
    return inspectionModel.toEntity();
  }

  @override
  Either<String, Inspection> getInspectionByProjectId(String projectId) {
    final inspectionList =
        _inspectionDatasource.getInspectionsByProjectId(projectId);
    if (inspectionList.isEmpty) {
      return Left('No hay ninguna inspeccion en este proyecto');
    }

    final inspection = inspectionList.last.toEntity();

    cacheInspection(inspection.projectId, inspection);
    return Right(inspection);
  }

  @override
  Future<void> cacheInspection(String projectId, Inspection inspection) async {
    _cache.save(projectId, inspection);
  }

  Future<Inspection?> _getCachedInspection(String inspectionId) async {
    return _cache.get(inspectionId);
  }

  @override
  Future<Either<String, Inspection>> getInspection(String inspectionId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _getCachedInspection(inspectionId);
      if (cached != null) return Right(cached);
    }

    final inspection =
        await _inspectionDatasource.getInspectionById(inspectionId);
    if (inspection == null) return Left('No se encontro la inspeccion');

    final inspectionEntity = inspection.toEntity();
    cacheInspection(inspectionId, inspectionEntity);

    return Right(inspectionEntity);
  }
}
