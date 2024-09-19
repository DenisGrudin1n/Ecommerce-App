import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({
    required this.storageRepository,
    required this.firestoreRepository,
  }) : super(const FilterState()) {
    on<ChangeMinValueEvent>(_onMinValueChanged);
    on<ChangeMaxValueEvent>(_onMaxValueChanged);
    on<ChangeRangeSliderEvent>(_onRangeSliderChanged);
    on<LoadCategoriesEvent>(_onLoadCategoriesChanged);
    on<ChangeCategoryEvent>(_onCategoryChanged);
    on<ToggleCategoryDropdownEvent>(_onToggleCategoryDropdown);
    on<LoadBrandsEvent>(_onLoadBrandsChanged);
    on<ChangeBrandEvent>(_onBrandChanged);
    on<ToggleBrandDropdownEvent>(_onToggleBrandDropdown);
    on<LoadColorsEvent>(_onLoadColors);
    on<ChangeColorEvent>(_onColorChanged);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;

  void _onMinValueChanged(
    ChangeMinValueEvent event,
    Emitter<FilterState> emit,
  ) {
    final minValue = event.minValue;
    final maxValue = state.maxValue >= minValue ? state.maxValue : minValue;

    emit(
      state.copyWith(
        minValue: minValue,
        maxValue: maxValue,
        rangeValues: RangeValues(minValue, maxValue),
      ),
    );
  }

  void _onMaxValueChanged(
    ChangeMaxValueEvent event,
    Emitter<FilterState> emit,
  ) {
    final maxValue = event.maxValue;
    final minValue = state.minValue <= maxValue ? state.minValue : maxValue;

    emit(
      state.copyWith(
        maxValue: maxValue,
        minValue: minValue,
        rangeValues: RangeValues(minValue, maxValue),
      ),
    );
  }

  void _onRangeSliderChanged(
    ChangeRangeSliderEvent event,
    Emitter<FilterState> emit,
  ) {
    final rangeValues = event.rangeValues;
    final minValue = rangeValues.start;
    final maxValue = rangeValues.end;

    emit(
      state.copyWith(
        rangeValues: rangeValues,
        minValue: minValue,
        maxValue: maxValue,
      ),
    );
  }

  Future<void> _onLoadCategoriesChanged(
    LoadCategoriesEvent event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingCategories: true,
        categoriesErrorMessage: '',
      ),
    );

    try {
      final categories = await firestoreRepository.getAllItemsCategories();
      emit(
        state.copyWith(
          categories: categories,
          isLoadingCategories: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoriesErrorMessage: e.toString(),
          isLoadingCategories: false,
        ),
      );
    }
  }

  void _onCategoryChanged(
    ChangeCategoryEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCategory: event.selectedCategory,
      ),
    );
  }

  void _onToggleCategoryDropdown(
    ToggleCategoryDropdownEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        isCategoryDropdownOpen: !state.isCategoryDropdownOpen,
      ),
    );
  }

  Future<void> _onLoadBrandsChanged(
    LoadBrandsEvent event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingBrands: true,
        brandsErrorMessage: '',
      ),
    );

    try {
      final brands = await firestoreRepository.getAllBrands();
      emit(
        state.copyWith(
          brands: brands,
          isLoadingBrands: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          brandsErrorMessage: e.toString(),
          isLoadingBrands: false,
        ),
      );
    }
  }

  void _onBrandChanged(
    ChangeBrandEvent event,
    Emitter<FilterState> emit,
  ) {
    final brandName = event.brandName;
    final currentSelectedBrands = List<String>.from(state.selectedBrands);

    if (brandName == 'All') {
      currentSelectedBrands
        ..clear()
        ..add('All');
    } else {
      currentSelectedBrands.remove('All');

      if (currentSelectedBrands.contains(brandName)) {
        currentSelectedBrands.remove(brandName);
      } else {
        currentSelectedBrands.add(brandName);
      }

      if (currentSelectedBrands.isEmpty) {
        currentSelectedBrands.add('All');
      }
    }

    emit(
      state.copyWith(
        selectedBrands: currentSelectedBrands,
      ),
    );
  }

  void _onToggleBrandDropdown(
    ToggleBrandDropdownEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        isBrandDropdownOpen: !state.isBrandDropdownOpen,
      ),
    );
  }

  void _onLoadColors(LoadColorsEvent event, Emitter<FilterState> emit) {
    final colors = [
      AppColors.darkColor,
      AppColors.redColor,
      AppColors.greenColor,
      AppColors.blueColor,
      AppColors.purpleColor,
      AppColors.lightYellowColor,
    ];
    emit(state.copyWith(colors: colors));
  }

  void _onColorChanged(ChangeColorEvent event, Emitter<FilterState> emit) {
    final selectedColors = List<Color>.from(state.selectedColors);
    if (selectedColors.contains(event.color)) {
      selectedColors.remove(event.color);
    } else {
      selectedColors.add(event.color);
    }
    emit(state.copyWith(selectedColors: selectedColors));
  }
}
