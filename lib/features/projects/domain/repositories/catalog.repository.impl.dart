import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/data/models/section.model.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';

@LazySingleton(as: CatalogRepository)
class CatalogRepositoryImpl implements CatalogRepository {
  @override
  Future<Either<String, List<Section>>> getCatalog() async {
    try {
      final jsonString = await rootBundle.loadString('assets/catalog.json');

      final jsonList = json.decode(jsonString) as List<dynamic>;
      final sections = jsonList
          .map((item) => SectionModel.fromJson(item).toEntity())
          .toList();

      return Either.right(sections);
    } catch (e) {
      return Either.left('Error al cargar el catálogo de inspección: $e');
    }
  }
}
