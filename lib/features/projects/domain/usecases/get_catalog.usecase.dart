import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';

@injectable
class GetCatalogUseCase {
  final CatalogRepository _repository;

  GetCatalogUseCase(this._repository);

  Future<Either<String, List<Section>>> call() async {
    return await _repository.getCatalog();
  }
}
