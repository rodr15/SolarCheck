import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

@lazySingleton
class InspectionCache {
  final Map<String, Inspection> _cache = {};

  Inspection? get(String projectId) => _cache[projectId];

  void save(String projectId, Inspection inspection) {
    _cache[projectId] = inspection;
  }

  void clear(String projectId) {
    _cache.remove(projectId);
  }

  void clearAll() {
    _cache.clear();
  }
}
