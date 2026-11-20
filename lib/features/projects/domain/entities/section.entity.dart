import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

part 'section.entity.freezed.dart';

@freezed
abstract class Section with _$Section {
  const factory Section({
    required String title,
    required List<SectionItem> items,
  }) = _Section;
}

@freezed
abstract class SectionItem with _$SectionItem {
  const SectionItem._();
  const factory SectionItem({
    @Default('') String title,
    @Default(false) bool couldHaveComments,
    String? subSectionTitle,
    @Default([]) List<SectionItem> subItems,
    @Default('') String? comments,
    @Default(ValidationStatus.pending) ValidationStatus status,
  }) = _SectionItem;

  bool get isSection => subSectionTitle != null || subItems.isNotEmpty;
  bool get isItem => !isSection;
}
