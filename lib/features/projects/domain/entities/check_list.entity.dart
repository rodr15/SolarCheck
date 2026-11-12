import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

class ChecklistItem {
  final String item;
  final bool hasComments;
  final ValidationStatus status;
  final String? comments;

  ChecklistItem({
    required this.item,
    required this.hasComments,
    required this.status,
    this.comments,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      item: json['item'] as String,
      hasComments: json['hasComments'] as bool,
      status: ValidationStatus.pending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'hasComments': hasComments,
    };
  }
}
