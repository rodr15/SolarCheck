import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';
import 'package:solar_check/features/projects/domain/repositories/inspection.repository.dart';

@injectable
class CreateInspectionUseCase {
  const CreateInspectionUseCase({
    required InspectionRepository repository,
    required CatalogRepository catalogRepository,
  })  : _repository = repository,
        _catalogRepository = catalogRepository;

  final InspectionRepository _repository;
  final CatalogRepository _catalogRepository;

  Future<Either<Inspection, String>> call(String projectId) async {
    final catalogEither = await _catalogRepository.getCatalog();

    return catalogEither.fold(
      (failure) => Right(failure),
      (catalogAnswers) async {
        final inspection = Inspection(
          projectId: projectId,
          updatedAt: DateTime.now(),
          inspectionAnswers: catalogAnswers,
        );
        final createdInspection = await _repository.saveInspection(inspection);
        return Left(createdInspection);
      },
    );
  }
}
