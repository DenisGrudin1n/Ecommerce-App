import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {
  CatalogueBloc({
    required this.storageRepository,
    required this.firestoreRepository,
  }) : super(const CatalogueState()) {
    on<LoadCatalogueItemsEvent>(_onCatalogueChanged);
    on<LoadCatalogueSubcategoriesEvent>(_onCatalogueSubcategoriesChanged);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;

  Future<void> _onCatalogueChanged(
    LoadCatalogueItemsEvent event,
    Emitter<CatalogueState> emit,
  ) async {
    final query = event.query;
    emit(state.copyWith(isLoadingCatalogue: true, catalogueErrorMessage: ''));

    try {
      final categories = query.isEmpty
          ? await firestoreRepository.getAllCatalogueItems()
          : await firestoreRepository.searchCatalogueItems(query);
      emit(
        state.copyWith(
          catalogueCategories: categories,
          isLoadingCatalogue: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          catalogueErrorMessage: e.toString(),
          isLoadingCatalogue: false,
        ),
      );
    }
  }

  Future<void> _onCatalogueSubcategoriesChanged(
    LoadCatalogueSubcategoriesEvent event,
    Emitter<CatalogueState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingSubcategories: true,
        subcategoriesErrorMessage: '',
      ),
    );

    try {
      final subcategories =
          await firestoreRepository.getAllCatalogueSubcategories();
      emit(
        state.copyWith(
          catalogueSubcategories: subcategories,
          isLoadingSubcategories: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          subcategoriesErrorMessage: e.toString(),
          isLoadingSubcategories: false,
        ),
      );
    }
  }
}
