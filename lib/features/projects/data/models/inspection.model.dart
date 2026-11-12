import 'package:hive_ce/hive_ce.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/entities/inspection_catalog.entity.dart';

part 'inspection.model.g.dart';

@HiveType(typeId: 2)
class InspectionModel extends Inspection {
  @HiveField(0)
  @override
  final String inspectionId;

  @HiveField(1)
  @override
  final String projectId;

  @HiveField(2)
  @override
  DateTime updatedAt;

  @HiveField(3)
  Map<String, dynamic> answers;

  InspectionModel({
    required this.inspectionId,
    required this.projectId,
    required this.updatedAt,
    required this.answers,
  }) : super(
          inspectionId: inspectionId,
          projectId: projectId,
          updatedAt: updatedAt,
          inspectionAnswers: InspectionCatalog.fromJson(answers),
        );

  factory InspectionModel.fromEntity(Inspection entity) {
    return InspectionModel(
      inspectionId: entity.inspectionId,
      projectId: entity.projectId,
      updatedAt: entity.updatedAt,
      answers: entity.inspectionAnswers.catalog,
    );
  }

  Inspection toEntity() {
    return Inspection(
      inspectionId: inspectionId,
      projectId: projectId,
      updatedAt: updatedAt,
      inspectionAnswers: InspectionCatalog.fromJson(answers),
    );
  }
}
