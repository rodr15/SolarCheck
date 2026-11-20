import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/data/models/section.model.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';

part 'inspection.model.freezed.dart';
part 'inspection.model.g.dart';

@freezed
abstract class InspectionModel with _$InspectionModel {
  const InspectionModel._();
  const factory InspectionModel({
    @JsonKey(name: "inspectionId") required String inspectionId,
    @JsonKey(name: "projectId") required String projectId,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
    @JsonKey(name: "answer") required List<SectionModel> answer,
  }) = _InspectionModel;

  factory InspectionModel.fromJson(Map<String, dynamic> json) =>
      _$InspectionModelFromJson(json);

  Inspection toEntity() => Inspection(
      projectId: projectId,
      inspectionId: inspectionId,
      updatedAt: updatedAt,
      inspectionAnswers: answer.map((a) => a.toEntity()).toList());

  factory InspectionModel.fromEntity(Inspection entity) => InspectionModel(
        inspectionId: entity.inspectionId,
        projectId: entity.projectId,
        updatedAt: entity.updatedAt,
        answer: entity.inspectionAnswers
            .map((a) => SectionModel.fromEntity(a))
            .toList(),
      );
}
