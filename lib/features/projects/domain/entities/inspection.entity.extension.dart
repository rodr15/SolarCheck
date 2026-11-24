import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.extension.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

extension InspectionUpdateX on Inspection {
  Inspection updateSectionItem({
    required SectionItem previousItem,
    required SectionItem updatedItem,
  }) {
    final updatedSections = inspectionAnswers
        .map(
          (section) => section.replaceItem(
            previousItem: previousItem,
            updatedItem: updatedItem,
          ) as Section,
        )
        .toList();

    return copyWith(inspectionAnswers: updatedSections);
  }

  List<SectionItem> getAllFlattenItems() {
    return inspectionAnswers
        .expand((section) => section.getFlattenItems())
        .toList();
  }

  Map<ValidationStatus, int> getValidationStatusQty() {
    final statusQty = {
      for (final status in ValidationStatus.values) status: 0,
    };

    for (final item in getAllFlattenItems()) {
      if (item.comments != null) print('${item.title} - ${item.comments}');
      statusQty[item.status] = (statusQty[item.status] ?? 0) + 1;
    }

    return statusQty;
  }
}
