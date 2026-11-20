import 'package:fpdart/fpdart.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';

abstract class CatalogRepository {
  Future<Either<String, List<Section>>> getCatalog();
}
