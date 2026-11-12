part of 'catalog_bloc.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.initial() = _Initial;
  const factory CatalogState.loading() = _Loading;
  const factory CatalogState.loaded(final InspectionCatalog catalog) = _Loaded;
  const factory CatalogState.error(final String error) = _Error;
}
