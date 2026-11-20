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
    return Option.fromNullable(answersByTitle[catalogSection.title]).match(
      () => catalogSection,
      (answerSection) => answerSection.copyWith(
        items: _syncItems(catalogSection.items, answerSection.items),
      ),
    );
  }

  List<SectionItem> _syncItems(
    List<SectionItem> catalogItems,
    List<SectionItem> answerItems,
  ) {
    if (answerItems.isEmpty) return catalogItems;

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
    return Option.fromNullable(answersByTitle[catalogItem.title]).match(
      () => catalogItem,
      (answerItem) => answerItem.copyWith(
        subItems: _syncItems(catalogItem.subItems, answerItem.subItems),
      ),
    );
  }
}
