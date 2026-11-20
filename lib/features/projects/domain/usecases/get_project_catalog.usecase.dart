import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';
import 'package:solar_check/features/projects/domain/services/catalog_sync.service.dart';

class GetProjectInspectionUseCase {
  final InspectionRepository _inspectionRepository;
  final CatalogRepository _catalogRepository;
  final CatalogSyncService _catalogSyncService;

  GetProjectInspectionUseCase({
    required InspectionRepository inspectionRepository,
    required CatalogRepository catalogRepository,
    required CatalogSyncService catalogSyncService,
  })  : _catalogSyncService = catalogSyncService,
        _inspectionRepository = inspectionRepository,
        _catalogRepository = catalogRepository;

  Future<Either<Inspection, String>> call(String projectId) async {
    final mandatoryTemplate = await _catalogRepository.getCatalog();

    if (mandatoryTemplate.isLeft()) {
      return Either.right('No se pudo obtener el catalogo de preguntas ');
    }

    final userInspectionData = _inspectionRepository.getInspection(projectId);

    if (userInspectionData.isLeft()) {
      return Either.right('No se pudo obtener la inspeccion');
    }

    final mandatoryCatalog = mandatoryTemplate.getRight().toNullable()!;
    final inspectionData = userInspectionData.getRight().toNullable()!;

    final synchronizedInspection = _catalogSyncService.synchronize(
      catalog: mandatoryCatalog,
      answers: inspectionData.inspectionAnswers,
    );

    final inspectionSync =
        inspectionData.copyWith(inspectionAnswers: synchronizedInspection);

    return Either.left(inspectionSync);
  }
}
