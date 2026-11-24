import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

part 'section.entity.freezed.dart';

@freezed
class SectionEntry with _$SectionEntry {
  const SectionEntry();
}

@freezed
abstract class Section extends SectionEntry with _$Section {
  const Section._();
  const factory Section({
    required String title,
    required List<SectionEntry> items,
  }) = _Section;

  List<SectionItem> getFlattenItems({String? parent}) {
    List<SectionItem> flattenItems = [];

    for (SectionEntry i in items) {
      if (i is Section) {
        flattenItems.addAll(i.getFlattenItems(parent: i.title));
        continue;
      }
      if (i is SectionItem) {
        final item = i.copyWith(parentTitle: parent ?? '');
        flattenItems.add(item);
        continue;
      }
    }

    return flattenItems;
  }
}

@freezed
abstract class SectionItem extends SectionEntry with _$SectionItem {
  const SectionItem._();
  const factory SectionItem({
    required String title,
    @Default(false) bool couldHaveComments,
    String? comments,
    @Default(ValidationStatus.withoutValidation) ValidationStatus status,
    @Default('') String parentTitle,
  }) = _SectionItem;
}
