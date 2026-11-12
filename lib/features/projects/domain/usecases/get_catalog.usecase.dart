import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';

import '../entities/inspection_catalog.entity.dart';

@injectable
class GetCatalogUseCase {
  final CatalogRepository _repository;

  GetCatalogUseCase(this._repository);

  Future<Either<InspectionCatalog, String>> call() async {
    return await _repository.getCatalog();
  }
}
