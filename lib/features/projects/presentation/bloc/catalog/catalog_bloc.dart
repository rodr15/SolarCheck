import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection_catalog.entity.dart';
import 'package:solar_check/features/projects/domain/repositories/catalog.repository.dart';

part 'catalog_bloc.freezed.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

@injectable
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogRepository catalogRepository;
  CatalogBloc(this.catalogRepository) : super(_Initial()) {
    on<_Load>(_load);
  }
  Future<void> _load(_Load event, Emitter<CatalogState> emit) async {
    emit(_Loading());

    Either<InspectionCatalog, String> catalogResponse =
        await catalogRepository.getCatalog();

    catalogResponse.fold(
      (catalog) => emit(CatalogState.loaded(catalog)),
      (error) => emit(CatalogState.error(error)),
    );
  }
}
