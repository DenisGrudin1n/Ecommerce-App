import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.featuredProducts = const [],
    this.homeCatalogueCategories = const [],
    this.fashionSaleImages = const [],
    this.isLoadingFeatured = false,
    this.isLoadingHomeCatalogue = false,
    this.isLoadingFashionSale = false,
    this.featuredErrorMessage = '',
    this.homeCatalogueErrorMessage = '',
    this.fashionSaleErrorMessage = '',
  });

  final List<ProductModel> featuredProducts;
  final List<CatalogueModel> homeCatalogueCategories;
  final List<FashionSaleModel> fashionSaleImages;

  // Loading states for each section
  final bool isLoadingFeatured;
  final bool isLoadingHomeCatalogue;
  final bool isLoadingFashionSale;

  // Error messages for each section
  final String featuredErrorMessage;
  final String homeCatalogueErrorMessage;
  final String fashionSaleErrorMessage;

  HomeState copyWith({
    List<ProductModel>? featuredProducts,
    List<CatalogueModel>? homeCatalogueCategories,
    List<FashionSaleModel>? fashionSaleImages,
    bool? isLoadingFeatured,
    bool? isLoadingHomeCatalogue,
    bool? isLoadingFashionSale,
    String? featuredErrorMessage,
    String? homeCatalogueErrorMessage,
    String? fashionSaleErrorMessage,
  }) {
    return HomeState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
      homeCatalogueCategories:
          homeCatalogueCategories ?? this.homeCatalogueCategories,
      fashionSaleImages: fashionSaleImages ?? this.fashionSaleImages,
      isLoadingFeatured: isLoadingFeatured ?? this.isLoadingFeatured,
      isLoadingHomeCatalogue:
          isLoadingHomeCatalogue ?? this.isLoadingHomeCatalogue,
      isLoadingFashionSale: isLoadingFashionSale ?? this.isLoadingFashionSale,
      featuredErrorMessage: featuredErrorMessage ?? this.featuredErrorMessage,
      homeCatalogueErrorMessage:
          homeCatalogueErrorMessage ?? this.homeCatalogueErrorMessage,
      fashionSaleErrorMessage:
          fashionSaleErrorMessage ?? this.fashionSaleErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        featuredProducts,
        homeCatalogueCategories,
        fashionSaleImages,
        isLoadingFeatured,
        isLoadingHomeCatalogue,
        isLoadingFashionSale,
        featuredErrorMessage,
        homeCatalogueErrorMessage,
        fashionSaleErrorMessage,
      ];
}
