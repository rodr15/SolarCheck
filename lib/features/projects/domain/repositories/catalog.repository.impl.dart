import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';
import '../../domain/entities/inspection_catalog.entity.dart';

@LazySingleton(as: CatalogRepository)
class CatalogRepositoryImpl implements CatalogRepository {
  @override
  Future<Either<InspectionCatalog, String>> getCatalog() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/catalog.json');

      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      final catalogModel = InspectionCatalog.fromJson(jsonMap);

      return Either.left(catalogModel);
    } catch (e) {
      return Either.right('Error al cargar el catálogo de inspección: $e');
    }
  }
}
