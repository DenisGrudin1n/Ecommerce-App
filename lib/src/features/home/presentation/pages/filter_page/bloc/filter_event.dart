import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class ChangeMinValueEvent extends FilterEvent {
  const ChangeMinValueEvent(this.minValue);
  final double minValue;

  @override
  List<Object?> get props => [minValue];
}

class ChangeMaxValueEvent extends FilterEvent {
  const ChangeMaxValueEvent(this.maxValue);
  final double maxValue;

  @override
  List<Object?> get props => [maxValue];
}

class ChangeRangeSliderEvent extends FilterEvent {
  const ChangeRangeSliderEvent(this.rangeValues);
  final RangeValues rangeValues;

  @override
  List<Object?> get props => [rangeValues];
}

class LoadCategoriesEvent extends FilterEvent {}

class ChangeCategoryEvent extends FilterEvent {
  const ChangeCategoryEvent(this.selectedCategory);
  final String selectedCategory;

  @override
  List<Object?> get props => [selectedCategory];
}

class ToggleCategoryDropdownEvent extends FilterEvent {}

class LoadBrandsEvent extends FilterEvent {}

class ChangeBrandEvent extends FilterEvent {
  const ChangeBrandEvent(this.brandName);
  final String brandName;

  @override
  List<Object?> get props => [brandName];
}

class ToggleBrandDropdownEvent extends FilterEvent {}

class LoadColorsEvent extends FilterEvent {}

class ChangeColorEvent extends FilterEvent {
  const ChangeColorEvent(this.colorName);
  final String colorName;

  @override
  List<Object?> get props => [colorName];
}

class LoadSizesEvent extends FilterEvent {}

class ChangeSizeEvent extends FilterEvent {
  const ChangeSizeEvent(this.size);
  final String size;

  @override
  List<Object?> get props => [size];
}

class LoadSortByEvent extends FilterEvent {}

class ChangeSortByEvent extends FilterEvent {
  const ChangeSortByEvent(this.selectedSortBy);
  final String selectedSortBy;

  @override
  List<Object?> get props => [selectedSortBy];
}

class ToggleSortByDropdownEvent extends FilterEvent {}

class ClearFiltersEvent extends FilterEvent {}
