import 'package:flutter/material.dart';

enum ValidationStatus {
  approved,
  notApproved,
  pending,
  withoutValidation,
}

extension ValidationStatusExtension on ValidationStatus {
  static ValidationStatus? fromText(String text) {
    for (var status in ValidationStatus.values) {
      if (status.text.toLowerCase() == text.toLowerCase()) {
        return status;
      }
    }
    return null;
  }

  String get text {
    switch (this) {
      case ValidationStatus.approved:
        return 'Aprobado';
      case ValidationStatus.notApproved:
        return 'Fallo';
      case ValidationStatus.pending:
        return 'Pendiente';
      case ValidationStatus.withoutValidation:
        return 'Sin Calificar';
    }
  }

  String get shortText {
    switch (this) {
      case ValidationStatus.approved:
        return 'Apr.';
      case ValidationStatus.notApproved:
        return 'Fal.';
      case ValidationStatus.pending:
        return 'Pen.';
      case ValidationStatus.withoutValidation:
        return 'Sin Cal.';
    }
  }

  IconData get icon {
    switch (this) {
      case ValidationStatus.approved:
        return Icons.done;
      case ValidationStatus.notApproved:
        return Icons.close;
      case ValidationStatus.pending:
        return Icons.warning;
      case ValidationStatus.withoutValidation:
        return Icons.circle_outlined;
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case ValidationStatus.approved:
        return Theme.of(context).colorScheme.primary;
      case ValidationStatus.notApproved:
        return Colors.red;
      case ValidationStatus.pending:
        return Colors.orange;
      case ValidationStatus.withoutValidation:
        return Colors.transparent;
    }
  }
}
