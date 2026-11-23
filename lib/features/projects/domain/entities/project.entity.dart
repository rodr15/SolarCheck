import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:uuid/uuid.dart';

part 'project.entity.freezed.dart';

@freezed
class Project with _$Project {
  final String projectId;
  final String name;
  final String type;
  final Inspection? inspection;
  Project({
    String? projectId,
    required this.name,
    required this.type,
    this.inspection,
  }) : projectId = projectId ?? Uuid().v4();
}
