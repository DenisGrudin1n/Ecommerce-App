import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.storageRepository, required this.firestoreRepository})
      : super(const ImageLoaderInitialState()) {
    on<LoadFeaturedProductsEvent>(_onFeaturedProductsChanged);
    on<LoadCatalogueEvent>(_onCatalogueChanged);
    on<LoadFashionSaleImagesEvent>(_onFashionSaleImagesChanged);
    on<LoadImageEvent>(_onLoadImage);
    on<LoadImagesEvent>(_onLoadImages);
    on<BottomNavEvent>((event, emit) {
      emit(BottomNavState(event.tab));
    });
  }
  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;
  List<FeaturedProductModel> allFeaturedProducts = [];
  String currentQuery = '';

  Future<void> _onFeaturedProductsChanged(
    LoadFeaturedProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    currentQuery = query;
    emit(FeaturedSectionLoadingState());

    try {
      final filteredProducts = query.isEmpty
          ? await firestoreRepository.getAllFeaturedProducts()
          : await firestoreRepository.searchFeaturedProducts(query);
      emit(FeaturedSectionLoadedState(filteredProducts));
    } catch (e) {
      emit(FeaturedSectionErrorState(e.toString()));
    }
  }

  Future<void> _onCatalogueChanged(
    LoadCatalogueEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(CatalogueSectionLoadingState());

    try {
      final categories = await firestoreRepository.getAllCatalogueItems();
      emit(CatalogueSectionLoadedState(categories));
    } catch (e) {
      emit(CatalogueSectionErrorState(e.toString()));
    }
  }

  Future<void> _onFashionSaleImagesChanged(
    LoadFashionSaleImagesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(FashionSaleSectionLoadingState());

    try {
      final images = await firestoreRepository.getAllFashionSaleImages();
      emit(FashionSaleSectionLoadedState(images));
    } catch (e) {
      emit(FashionSaleSectionErrorState(e.toString()));
    }
  }

  Future<void> _onLoadImage(
    LoadImageEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is ImageLoaderInitialState) {
      final updatedImageUrls = Map<String, String>.from(currentState.imageUrls);
      emit(ImageLoadingState(imageUrls: updatedImageUrls));

      try {
        final downloadURL =
            await storageRepository.getDownloadURL(event.imagePath);
        if (downloadURL != null) {
          updatedImageUrls[event.imagePath] = downloadURL;
          emit(ImageLoadedState(imageUrls: updatedImageUrls));
        } else {
          emit(ImageLoadFailureState(imageUrls: updatedImageUrls));
        }
      } catch (_) {
        emit(ImageLoadFailureState(imageUrls: updatedImageUrls));
      }
    }
  }

  Future<void> _onLoadImages(
    LoadImagesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is ImageLoaderInitialState) {
      final updatedImageUrls = Map<String, String>.from(currentState.imageUrls);
      emit(ImageLoadingState(imageUrls: updatedImageUrls));

      try {
        final futures = event.imagePaths.map((path) async {
          final downloadURL = await storageRepository.getDownloadURL(path);
          if (downloadURL != null) {
            updatedImageUrls[path] = downloadURL;
          }
        }).toList();

        await Future.wait(futures);
        emit(ImageLoadedState(imageUrls: updatedImageUrls));
      } catch (_) {
        emit(ImageLoadFailureState(imageUrls: updatedImageUrls));
      }
    }
  }
}
