import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:flutter/material.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({
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
    on<LoadSizesEvent>(_onLoadSizesChanged);
    on<ChangeSizeEvent>(_onSizeChanged);
    on<LoadSortByEvent>(_onLoadSortByChanged);
    on<ChangeSortByEvent>(_onSortByChanged);
    on<ToggleSortByDropdownEvent>(_onToggleSortByDropdown);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  List<SizeModel> _initialSizes = [];
  List<ItemsCategoriesModel> _initialCategories = [];
  List<BrandModel> _initialBrands = [];
  Map<String, Color> _initialColors = {};
  List<SortByModel> _initialSortBy = [];

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
      _initialCategories = categories;

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
      _initialBrands = brands;

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
    _initialColors = {
      'Red': AppColors.redColor,
      'Black': AppColors.darkColor,
      'Green': AppColors.lightGreenColor,
      'Blue': AppColors.blueColor,
      'Purple': AppColors.purpleColor,
      'Yellow': AppColors.lightYellowColor,
    };

    emit(state.copyWith(colors: _initialColors));
  }

  void _onColorChanged(
    ChangeColorEvent event,
    Emitter<FilterState> emit,
  ) {
    final colorName = event.colorName;
    final color = state.colors[colorName];

    if (color != null) {
      final currentSelectedColors =
          Map<String, Color>.from(state.selectedColors);

      if (currentSelectedColors.containsKey(colorName)) {
        currentSelectedColors.remove(colorName);
      } else {
        currentSelectedColors[colorName] = color;
      }

      emit(
        state.copyWith(
          selectedColors: currentSelectedColors,
        ),
      );
    }
  }

  Future<void> _onLoadSizesChanged(
    LoadSizesEvent event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingSizes: true,
        sizesErrorMessage: '',
      ),
    );

    try {
      final sizes = await firestoreRepository.getAllSizes();
      _initialSizes = sizes;

      emit(
        state.copyWith(
          sizes: sizes,
          isLoadingSizes: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          sizesErrorMessage: e.toString(),
          isLoadingSizes: false,
        ),
      );
    }
  }

  void _onSizeChanged(ChangeSizeEvent event, Emitter<FilterState> emit) {
    final selectedSizes = List<String>.from(state.selectedSizes);
    if (selectedSizes.contains(event.size)) {
      selectedSizes.remove(event.size);
    } else {
      selectedSizes.add(event.size);
    }
    emit(state.copyWith(selectedSizes: selectedSizes));
  }

  Future<void> _onLoadSortByChanged(
    LoadSortByEvent event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingSortBy: true,
        sortByErrorMessage: '',
      ),
    );

    try {
      final sortBy = await firestoreRepository.getAllSortBy();
      _initialSortBy = sortBy;

      emit(
        state.copyWith(
          sortBy: sortBy,
          isLoadingSortBy: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          sortByErrorMessage: e.toString(),
          isLoadingSortBy: false,
        ),
      );
    }
  }

  void _onSortByChanged(
    ChangeSortByEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        selectedSortBy: event.selectedSortBy,
      ),
    );
  }

  void _onToggleSortByDropdown(
    ToggleSortByDropdownEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        isSortByDropdownOpen: !state.isSortByDropdownOpen,
      ),
    );
  }

  void _onClearFilters(
    ClearFiltersEvent event,
    Emitter<FilterState> emit,
  ) {
    emit(
      state.copyWith(
        minValue: 0,
        maxValue: 9999,
        rangeValues: const RangeValues(0, 9999),
        categories: _initialCategories,
        brands: _initialBrands,
        selectedBrands: const ['All'],
        colors: _initialColors,
        selectedColors: const {},
        sizes: _initialSizes,
        selectedSizes: const [],
        sortBy: _initialSortBy,
        selectedCategory: 'All',
        selectedSortBy: 'Featured',
        isLoadingCategories: false,
        isLoadingBrands: false,
        isLoadingSizes: false,
        isLoadingSortBy: false,
        categoriesErrorMessage: '',
        brandsErrorMessage: '',
        colorsErrorMessage: '',
        sizesErrorMessage: '',
        sortByErrorMessage: '',
      ),
    );
  }
}
