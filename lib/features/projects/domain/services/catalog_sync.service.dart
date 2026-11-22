import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';

@lazySingleton
class CatalogSyncService {
  const CatalogSyncService();

  List<Section> synchronize({
    required List<Section> catalog,
    required List<Section> answers,
  }) {
    if (answers.isEmpty) return List.unmodifiable(catalog);

    final answersByTitle = {
      for (final section in answers) section.title: section,
    };

    return catalog
        .map((catalogSection) => _syncSection(catalogSection, answersByTitle))
        .toList(growable: false);
  }

  Section _syncSection(
    Section catalogSection,
    Map<String, Section> answersByTitle,
  ) {
    if (catalogSection.items.isEmpty) return catalogSection;

    final answerSection = answersByTitle[catalogSection.title];
    if (answerSection == null) return catalogSection;

    if (catalogSection.items.first is Section) {
      return answerSection.copyWith(
        items: synchronize(
          catalog: catalogSection.items.cast<Section>(),
          answers: answerSection.items.cast<Section>(),
        ),
      );
    }

    return Option.fromNullable(answerSection).match(
      () => catalogSection,
      (answerSection) => answerSection.copyWith(
        items: _syncItems(
          catalogSection.items.cast<SectionItem>(),
          answerSection.items.cast<SectionItem>(),
        ),
      ),
    );
  }

  List<SectionItem> _syncItems(
    List<SectionItem>? catalogItems,
    List<SectionItem>? answerItems,
  ) {
    if (catalogItems == null || catalogItems.isEmpty) return [];
    if (answerItems == null || answerItems.isEmpty) return catalogItems;

    final Map<String, SectionItem> answersByTitle = {
      for (final item in answerItems) item.title: item,
    };

    return catalogItems
        .map((catalogItem) => _syncSingleItem(catalogItem, answersByTitle))
        .toList(growable: false);
  }

  SectionItem _syncSingleItem(
    SectionItem catalogItem,
    Map<String, SectionItem> answersByTitle,
  ) {
    return Option.fromNullable(answersByTitle[catalogItem.title])
        .match(() => catalogItem, (answerItem) => answerItem);
  }

  bool needsSync({
    required List<Section> catalog,
    required List<Section> answers,
  }) {
    final answersByTitle = {
      for (final section in answers) section.title: section,
    };

    for (final section in catalog) {
      final answerSection = answersByTitle[section.title];
      if (answerSection == null || _itemsNeedSync(section, answerSection)) {
        return true;
      }
    }

    return false;
  }

  bool _itemsNeedSync(Section section, Section answerSection) {
    final answerTitles =
        answerSection.getFlattenItems().map((item) => item.title).toSet();

    return section
        .getFlattenItems()
        .any((item) => !answerTitles.contains(item.title));
  }
}
