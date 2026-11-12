import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/entities/inspection_catalog.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';
import 'package:solar_check/features/projects/domain/services/sync_catalog.dart';

class GetProjectInspectionUseCase {
  final InspectionRepository _inspectionRepository;
  final CatalogRepository _catalogRepository;

  GetProjectInspectionUseCase({
    required InspectionRepository inspectionRepository,
    required CatalogRepository catalogRepository,
  })  : _inspectionRepository = inspectionRepository,
        _catalogRepository = catalogRepository;

  Future<Either<Inspection, String>> call(String projectId) async {
    final mandatoryTemplate = await _catalogRepository.getCatalog();

    if (mandatoryTemplate.isRight()) {
      return Either.right('No se pudo obtener el catalogo de preguntas ');
    }

    final userInspectionData =
        await _inspectionRepository.getInspection(projectId);

    if (userInspectionData.isRight()) {
      return Either.right('No se pudo obtener la inspeccion');
    }

    final mandatoryCatalog = mandatoryTemplate.getLeft().toNullable()!;
    final inspectionData = userInspectionData.getLeft().toNullable()!;

    final synchronizedInspection = GenericStructureSynchronizer.synchronize(
      catalog: mandatoryCatalog.catalog,
      inspectionCatalog: inspectionData.inspectionAnswers.catalog,
    );

    final inspectionSync = inspectionData.copyWith(
        inspectionAnswers: InspectionCatalog.fromJson(synchronizedInspection));

    return Either.left(inspectionSync);
  }
}
