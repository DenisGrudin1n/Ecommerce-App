import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.storageRepository, required this.firestoreRepository})
      : super(const HomeState()) {
    on<LoadFeaturedProductsEvent>(_onFeaturedProductsChanged);
    on<LoadHomeCatalogueEvent>(_onHomeCatalogueChanged);
    on<LoadFashionSaleImagesEvent>(_onFashionSaleImagesChanged);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;
  String currentQuery = '';

  Future<void> _onFeaturedProductsChanged(
    LoadFeaturedProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    currentQuery = query;
    emit(state.copyWith(isLoadingFeatured: true, featuredErrorMessage: ''));

    try {
      final filteredProducts = query.isEmpty
          ? await firestoreRepository.getAllFeaturedProducts()
          : await firestoreRepository.searchFeaturedProducts(query);
      emit(
        state.copyWith(
          featuredProducts: filteredProducts,
          isLoadingFeatured: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          featuredErrorMessage: e.toString(),
          isLoadingFeatured: false,
        ),
      );
    }
  }

  Future<void> _onHomeCatalogueChanged(
    LoadHomeCatalogueEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingHomeCatalogue: true,
        homeCatalogueErrorMessage: '',
      ),
    );

    try {
      final categories = await firestoreRepository.getAllHomeCatalogueItems();
      emit(
        state.copyWith(
          homeCatalogueCategories: categories,
          isLoadingHomeCatalogue: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          homeCatalogueErrorMessage: e.toString(),
          isLoadingHomeCatalogue: false,
        ),
      );
    }
  }

  Future<void> _onFashionSaleImagesChanged(
    LoadFashionSaleImagesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingFashionSale: true,
        fashionSaleErrorMessage: '',
      ),
    );

    try {
      final images = await firestoreRepository.getAllFashionSaleImages();
      emit(
        state.copyWith(
          fashionSaleImages: images,
          isLoadingFashionSale: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fashionSaleErrorMessage: e.toString(),
          isLoadingFashionSale: false,
        ),
      );
    }
  }
}
