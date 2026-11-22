import 'package:solar_check/features/projects/domain/entities/section.entity.dart';

extension SectionEntryUpdateX on SectionEntry {
  SectionEntry replaceItem({
    required SectionItem previousItem,
    required SectionItem updatedItem,
  }) {
    final current = this;

    if (current is Section) {
      final updatedChildren = current.items
          .map(
            (entry) => entry.replaceItem(
              previousItem: previousItem,
              updatedItem: updatedItem,
            ),
          )
          .toList();

      return current.copyWith(items: updatedChildren);
    }

    if (current is SectionItem && identical(current, previousItem)) {
      return updatedItem;
    }

    return current;
  }
}
