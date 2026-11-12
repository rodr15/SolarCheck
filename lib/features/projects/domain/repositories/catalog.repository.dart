import 'package:fpdart/fpdart.dart';

import '../entities/inspection_catalog.entity.dart';

abstract class CatalogRepository {
  Future<Either<InspectionCatalog, String>> getCatalog();
}
