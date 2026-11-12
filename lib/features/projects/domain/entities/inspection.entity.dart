import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/inspection_catalog.entity.dart';
import 'package:uuid/uuid.dart';

part 'inspection.entity.freezed.dart';

@freezed
class Inspection with _$Inspection {
  final String inspectionId;
  final String projectId;
  final DateTime updatedAt;
  final InspectionCatalog inspectionAnswers;

  Inspection({
    String? inspectionId,
    required this.projectId,
    required this.updatedAt,
    required this.inspectionAnswers,
  }) : inspectionId = inspectionId ?? const Uuid().v4();
}
