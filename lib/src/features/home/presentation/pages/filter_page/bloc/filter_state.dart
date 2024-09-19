import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
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
    this.colors = const [],
    this.selectedColors = const [],
    this.sizes = const [],
    this.selectedSizes = const [],
    this.isLoadingCategories = false,
    this.isLoadingBrands = false,
    this.isLoadingSizes = false,
    this.isCategoryDropdownOpen = false,
    this.isBrandDropdownOpen = false,
    this.selectedCategory = 'All',
    this.categoriesErrorMessage = '',
    this.brandsErrorMessage = '',
    this.colorsErrorMessage = '',
    this.sizesErrorMessage = '',
  });

  final double minValue;
  final double maxValue;

  final RangeValues rangeValues;

  final List<ItemsCategoriesModel> categories;
  final List<BrandModel> brands;
  final List<String> selectedBrands;
  final List<Color> colors;
  final List<Color> selectedColors;
  final List<SizeModel> sizes;
  final List<String> selectedSizes;

  final bool isLoadingCategories;
  final bool isLoadingBrands;
  final bool isLoadingSizes;
  final bool isCategoryDropdownOpen;
  final bool isBrandDropdownOpen;

  final String selectedCategory;

  final String categoriesErrorMessage;
  final String brandsErrorMessage;
  final String colorsErrorMessage;
  final String sizesErrorMessage;

  FilterState copyWith({
    double? minValue,
    double? maxValue,
    RangeValues? rangeValues,
    List<ItemsCategoriesModel>? categories,
    List<BrandModel>? brands,
    List<String>? selectedBrands,
    List<Color>? colors,
    List<Color>? selectedColors,
    List<SizeModel>? sizes,
    List<String>? selectedSizes,
    bool? isLoadingCategories,
    bool? isLoadingBrands,
    bool? isLoadingSizes,
    bool? isCategoryDropdownOpen,
    bool? isBrandDropdownOpen,
    String? selectedCategory,
    String? categoriesErrorMessage,
    String? brandsErrorMessage,
    String? colorsErrorMessage,
    String? sizesErrorMessage,
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
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingBrands: isLoadingBrands ?? this.isLoadingBrands,
      isLoadingSizes: isLoadingSizes ?? this.isLoadingSizes,
      isCategoryDropdownOpen:
          isCategoryDropdownOpen ?? this.isCategoryDropdownOpen,
      isBrandDropdownOpen: isBrandDropdownOpen ?? this.isBrandDropdownOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
      brandsErrorMessage: brandsErrorMessage ?? this.brandsErrorMessage,
      colorsErrorMessage: colorsErrorMessage ?? this.colorsErrorMessage,
      sizesErrorMessage: sizesErrorMessage ?? this.sizesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        minValue,
        maxValue,
        rangeValues,
        categories,
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
        selectedCategory,
        categoriesErrorMessage,
        brandsErrorMessage,
        colorsErrorMessage,
        sizesErrorMessage,
      ];
}
