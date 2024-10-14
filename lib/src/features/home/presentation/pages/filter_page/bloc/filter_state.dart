import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterState extends Equatable {
  const FilterState({
    this.minValue = 0.0,
    this.maxValue = 9999.0,
    this.rangeValues = const RangeValues(0, 9999),
    this.categories = const [],
    this.brands = const [],
    this.selectedBrands = const ['All'],
    this.colors = const {},
    this.selectedColors = const {},
    this.sizes = const [],
    this.selectedSizes = const [],
    this.sortBy = const [],
    this.isLoadingCategories = false,
    this.isLoadingBrands = false,
    this.isLoadingSizes = false,
    this.isCategoryDropdownOpen = false,
    this.isBrandDropdownOpen = false,
    this.isLoadingSortBy = false,
    this.isSortByDropdownOpen = false,
    this.selectedCategory = 'All',
    this.selectedSortBy = 'Featured',
    this.categoriesErrorMessage = '',
    this.brandsErrorMessage = '',
    this.colorsErrorMessage = '',
    this.sizesErrorMessage = '',
    this.sortByErrorMessage = '',
  });

  final double minValue;
  final double maxValue;

  final RangeValues rangeValues;

  final List<ItemsCategoriesModel> categories;
  final List<BrandModel> brands;
  final List<String> selectedBrands;
  final Map<String, Color> colors;
  final Map<String, Color> selectedColors;
  final List<SizeModel> sizes;
  final List<String> selectedSizes;
  final List<SortByModel> sortBy;

  final bool isLoadingCategories;
  final bool isLoadingBrands;
  final bool isLoadingSizes;
  final bool isCategoryDropdownOpen;
  final bool isBrandDropdownOpen;
  final bool isLoadingSortBy;
  final bool isSortByDropdownOpen;

  final String selectedCategory;
  final String selectedSortBy;

  final String categoriesErrorMessage;
  final String brandsErrorMessage;
  final String colorsErrorMessage;
  final String sizesErrorMessage;
  final String sortByErrorMessage;

  FilterState copyWith({
    double? minValue,
    double? maxValue,
    RangeValues? rangeValues,
    List<ItemsCategoriesModel>? categories,
    List<BrandModel>? brands,
    List<String>? selectedBrands,
    Map<String, Color>? colors,
    Map<String, Color>? selectedColors,
    List<SizeModel>? sizes,
    List<String>? selectedSizes,
    List<SortByModel>? sortBy,
    bool? isLoadingCategories,
    bool? isLoadingBrands,
    bool? isLoadingSizes,
    bool? isCategoryDropdownOpen,
    bool? isBrandDropdownOpen,
    bool? isLoadingSortBy,
    bool? isSortByDropdownOpen,
    String? selectedCategory,
    String? selectedSortBy,
    String? categoriesErrorMessage,
    String? brandsErrorMessage,
    String? colorsErrorMessage,
    String? sizesErrorMessage,
    String? sortByErrorMessage,
  }) {
    return FilterState(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      rangeValues: rangeValues ?? this.rangeValues,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      colors: colors ?? this.colors,
      selectedColors: selectedColors ?? this.selectedColors,
      sizes: sizes ?? this.sizes,
      selectedSizes: selectedSizes ?? this.selectedSizes,
      sortBy: sortBy ?? this.sortBy,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingBrands: isLoadingBrands ?? this.isLoadingBrands,
      isLoadingSizes: isLoadingSizes ?? this.isLoadingSizes,
      isLoadingSortBy: isLoadingSortBy ?? this.isLoadingSortBy,
      isCategoryDropdownOpen:
          isCategoryDropdownOpen ?? this.isCategoryDropdownOpen,
      isBrandDropdownOpen: isBrandDropdownOpen ?? this.isBrandDropdownOpen,
      isSortByDropdownOpen: isSortByDropdownOpen ?? this.isSortByDropdownOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSortBy: selectedSortBy ?? this.selectedSortBy,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
      brandsErrorMessage: brandsErrorMessage ?? this.brandsErrorMessage,
      colorsErrorMessage: colorsErrorMessage ?? this.colorsErrorMessage,
      sizesErrorMessage: sizesErrorMessage ?? this.sizesErrorMessage,
      sortByErrorMessage: sortByErrorMessage ?? this.sortByErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        minValue,
        maxValue,
        rangeValues,
        categories,
        sortBy,
        brands,
        selectedBrands,
        colors,
        selectedColors,
        sizes,
        selectedSizes,
        isLoadingCategories,
        isLoadingBrands,
        isLoadingSizes,
        isCategoryDropdownOpen,
        isBrandDropdownOpen,
        isLoadingSortBy,
        isSortByDropdownOpen,
        selectedCategory,
        selectedSortBy,
        categoriesErrorMessage,
        brandsErrorMessage,
        colorsErrorMessage,
        sizesErrorMessage,
        sortByErrorMessage,
      ];
}
