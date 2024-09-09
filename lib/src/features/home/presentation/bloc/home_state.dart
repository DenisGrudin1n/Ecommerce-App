import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  Map<String, String> get imageUrls => const {};
  @override
  List<Object> get props => [];
}

// States for Featured Section
class FeaturedSectionInitialState extends HomeState {}

class FeaturedSectionLoadingState extends HomeState {}

class FeaturedSectionLoadedState extends HomeState {
  const FeaturedSectionLoadedState(this.products);
  final List<FeaturedProductModel> products;

  @override
  List<Object> get props => [products];
}

class FeaturedSectionErrorState extends HomeState {
  const FeaturedSectionErrorState(this.message);
  final String message;
}

// States for Catalogue
class CatalogueSectionInitialState extends HomeState {}

class CatalogueSectionLoadingState extends HomeState {}

class CatalogueSectionLoadedState extends HomeState {
  const CatalogueSectionLoadedState(this.categories);
  final List<CatalogueModel> categories;

  @override
  List<Object> get props => [categories];
}

class CatalogueSectionErrorState extends HomeState {
  const CatalogueSectionErrorState(this.message);
  final String message;
}

// States for Fashion Sale
class FashionSaleSectionInitialState extends HomeState {}

class FashionSaleSectionLoadingState extends HomeState {}

class FashionSaleSectionLoadedState extends HomeState {
  const FashionSaleSectionLoadedState(this.images);
  final List<FashionSaleModel> images;

  @override
  List<Object> get props => [images];
}

class FashionSaleSectionErrorState extends HomeState {
  const FashionSaleSectionErrorState(this.message);
  final String message;
}

// States for Catalogue Subcategories
class CatalogueSubcategoriesInitialState extends HomeState {}

class CatalogueSubcategoriesLoadingState extends HomeState {}

class CatalogueSubcategoriesLoadedState extends HomeState {
  const CatalogueSubcategoriesLoadedState(this.subcategories);
  final List<CatalogueSubcategoriesModel> subcategories;

  @override
  List<Object> get props => [subcategories];
}

class CatalogueSubcategoriesErrorState extends HomeState {
  const CatalogueSubcategoriesErrorState(this.message);
  final String message;
}

// States for Images
class ImageLoaderInitialState extends HomeState {
  const ImageLoaderInitialState({this.imageUrls = const {}});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadingState extends HomeState {
  const ImageLoadingState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadedState extends HomeState {
  const ImageLoadedState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadFailureState extends HomeState {
  const ImageLoadFailureState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

// States for Bottombar navigation
enum BottomNavTab { home, catalogue, favorite, profile }

class BottomNavState extends HomeState {
  const BottomNavState(this.selectedTab);
  final BottomNavTab selectedTab;

  @override
  List<Object> get props => [selectedTab];
}
