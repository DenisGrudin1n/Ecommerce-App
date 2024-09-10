import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:equatable/equatable.dart';

class CatalogueState extends Equatable {
  const CatalogueState({
    this.catalogueCategories = const [],
    this.catalogueSubcategories = const [],
    this.isLoadingCatalogue = false,
    this.isLoadingSubcategories = false,
    this.catalogueErrorMessage = '',
    this.subcategoriesErrorMessage = '',
  });

  final List<CatalogueModel> catalogueCategories;
  final List<CatalogueSubcategoriesModel> catalogueSubcategories;

  // Loading states for each event
  final bool isLoadingCatalogue;
  final bool isLoadingSubcategories;

  // Error messages for each evebt
  final String catalogueErrorMessage;
  final String subcategoriesErrorMessage;

  CatalogueState copyWith({
    List<CatalogueModel>? catalogueCategories,
    List<CatalogueSubcategoriesModel>? catalogueSubcategories,
    bool? isLoadingCatalogue,
    bool? isLoadingSubcategories,
    String? catalogueErrorMessage,
    String? subcategoriesErrorMessage,
  }) {
    return CatalogueState(
      catalogueCategories: catalogueCategories ?? this.catalogueCategories,
      catalogueSubcategories:
          catalogueSubcategories ?? this.catalogueSubcategories,
      isLoadingCatalogue: isLoadingCatalogue ?? this.isLoadingCatalogue,
      isLoadingSubcategories:
          isLoadingSubcategories ?? this.isLoadingSubcategories,
      catalogueErrorMessage:
          catalogueErrorMessage ?? this.catalogueErrorMessage,
      subcategoriesErrorMessage:
          subcategoriesErrorMessage ?? this.subcategoriesErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        catalogueCategories,
        catalogueSubcategories,
        isLoadingCatalogue,
        isLoadingSubcategories,
        catalogueErrorMessage,
        subcategoriesErrorMessage,
      ];
}
