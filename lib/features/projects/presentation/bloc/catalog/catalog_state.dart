part of 'catalog_bloc.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.initial() = _Initial;
  const factory CatalogState.loading() = _Loading;
  const factory CatalogState.loaded(List<Section> catalog) = _Loaded;
  const factory CatalogState.error(String error) = _Error;
}
