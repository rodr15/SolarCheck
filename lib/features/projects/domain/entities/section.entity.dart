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
}

@freezed
abstract class SectionItem extends SectionEntry with _$SectionItem {
  const SectionItem._();
  const factory SectionItem({
    required String title,
    @Default(false) bool couldHaveComments,
    String? comments,
    @Default(ValidationStatus.withoutValidation) ValidationStatus status,
  }) = _SectionItem;
}
