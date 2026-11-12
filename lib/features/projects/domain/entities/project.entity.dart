import 'package:uuid/uuid.dart';

class Project {
  final String projectId;
  final String name;
  final String type;

  Project({
    String? projectId,
    required this.name,
    required this.type,
  }) : projectId = projectId ?? Uuid().v4();
}
