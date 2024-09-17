import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterState extends Equatable {
  const FilterState({
    this.minValue = 0.0,
    this.maxValue = 9999.0,
    this.rangeValues = const RangeValues(0, 9999),
    this.categories = const [],
    this.selectedCategory = 'All',
    this.isLoadingCategories = false,
    this.categoriesErrorMessage = '',
    this.isDropdownOpen = false,
  });

  final double minValue;
  final double maxValue;
  final RangeValues rangeValues;
  final List<ItemsCategoriesModel> categories;
  final String selectedCategory;
  final bool isLoadingCategories;
  final String categoriesErrorMessage;
  final bool isDropdownOpen;

  FilterState copyWith({
    double? minValue,
    double? maxValue,
    RangeValues? rangeValues,
    List<ItemsCategoriesModel>? categories,
    String? selectedCategory,
    bool? isLoadingCategories,
    String? categoriesErrorMessage,
    bool? isDropdownOpen,
  }) {
    return FilterState(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      rangeValues: rangeValues ?? this.rangeValues,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
      isDropdownOpen: isDropdownOpen ?? this.isDropdownOpen,
    );
  }

  @override
  List<Object?> get props => [
        minValue,
        maxValue,
        rangeValues,
        categories,
        selectedCategory,
        isLoadingCategories,
        categoriesErrorMessage,
        isDropdownOpen,
      ];
}
