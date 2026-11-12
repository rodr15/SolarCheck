import 'package:flutter/material.dart';

enum ValidationStatus {
  approved,
  notApproved,
  pending,
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
        return 'No Aprobado';
      case ValidationStatus.pending:
        return 'Pendiente';
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
    }
  }
}
