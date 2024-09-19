import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
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
    this.isLoadingCategories = false,
    this.isLoadingBrands = false,
    this.isCategoryDropdownOpen = false,
    this.isBrandDropdownOpen = false,
    this.selectedCategory = 'All',
    this.categoriesErrorMessage = '',
    this.brandsErrorMessage = '',
  });

  final double minValue;
  final double maxValue;
  final RangeValues rangeValues;
  final List<ItemsCategoriesModel> categories;
  final List<BrandModel> brands;
  final List<String> selectedBrands;
  final bool isLoadingCategories;
  final bool isLoadingBrands;
  final bool isCategoryDropdownOpen;
  final bool isBrandDropdownOpen;
  final String selectedCategory;
  final String categoriesErrorMessage;
  final String brandsErrorMessage;

  FilterState copyWith({
    double? minValue,
    double? maxValue,
    RangeValues? rangeValues,
    List<ItemsCategoriesModel>? categories,
    List<BrandModel>? brands,
    List<String>? selectedBrands,
    bool? isLoadingCategories,
    bool? isLoadingBrands,
    bool? isCategoryDropdownOpen,
    bool? isBrandDropdownOpen,
    String? selectedCategory,
    String? categoriesErrorMessage,
    String? brandsErrorMessage,
  }) {
    return FilterState(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      rangeValues: rangeValues ?? this.rangeValues,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingBrands: isLoadingBrands ?? this.isLoadingBrands,
      isCategoryDropdownOpen:
          isCategoryDropdownOpen ?? this.isCategoryDropdownOpen,
      isBrandDropdownOpen: isBrandDropdownOpen ?? this.isBrandDropdownOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
      brandsErrorMessage: brandsErrorMessage ?? this.brandsErrorMessage,
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
        isLoadingCategories,
        isLoadingBrands,
        isCategoryDropdownOpen,
        isBrandDropdownOpen,
        selectedCategory,
        categoriesErrorMessage,
        brandsErrorMessage,
      ];
}
