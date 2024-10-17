import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:equatable/equatable.dart';

class ItemsState extends Equatable {
  const ItemsState({
    this.items = const [],
    this.itemsCategories = const [],
    this.sortBy = const [],
    this.isLoadingItems = false,
    this.isLoadingItemsCategories = false,
    this.isLoadingSortBy = false,
    this.isSortByDropdownOpen = false,
    this.selectedCategory = 'All',
    this.selectedSortBy = 'Featured',
    this.itemsErrorMessage = '',
    this.itemsCategoriesErrorMessage = '',
    this.sortByErrorMessage = '',
  });

  final List<ProductModel> items;
  final List<ItemsCategoriesModel> itemsCategories;
  final List<SortByModel> sortBy;
  final String selectedCategory;

  // Loading states for each section
  final bool isLoadingItems;
  final bool isLoadingItemsCategories;
  final bool isLoadingSortBy;
  final bool isSortByDropdownOpen;

  final String selectedSortBy;

  // Error messages for each section
  final String itemsErrorMessage;
  final String itemsCategoriesErrorMessage;
  final String sortByErrorMessage;

  ItemsState copyWith({
    List<ProductModel>? items,
    List<ItemsCategoriesModel>? itemsCategories,
    List<SortByModel>? sortBy,
    bool? isLoadingItems,
    bool? isLoadingItemsCategories,
    bool? isLoadingSortBy,
    bool? isSortByDropdownOpen,
    String? selectedCategory,
    String? selectedSortBy,
    String? itemsErrorMessage,
    String? itemsCategoriesErrorMessage,
    String? sortByErrorMessage,
  }) {
    return ItemsState(
      items: items ?? this.items,
      itemsCategories: itemsCategories ?? this.itemsCategories,
      sortBy: sortBy ?? this.sortBy,
      isLoadingItems: isLoadingItems ?? this.isLoadingItems,
      isLoadingItemsCategories:
          isLoadingItemsCategories ?? this.isLoadingItemsCategories,
      isLoadingSortBy: isLoadingSortBy ?? this.isLoadingSortBy,
      isSortByDropdownOpen: isSortByDropdownOpen ?? this.isSortByDropdownOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSortBy: selectedSortBy ?? this.selectedSortBy,
      itemsErrorMessage: itemsErrorMessage ?? this.itemsErrorMessage,
      itemsCategoriesErrorMessage:
          itemsCategoriesErrorMessage ?? this.itemsCategoriesErrorMessage,
      sortByErrorMessage: sortByErrorMessage ?? this.sortByErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        items,
        itemsCategories,
        sortBy,
        isLoadingItems,
        isLoadingItemsCategories,
        isLoadingSortBy,
        isSortByDropdownOpen,
        selectedCategory,
        selectedSortBy,
        itemsErrorMessage,
        itemsCategoriesErrorMessage,
        sortByErrorMessage,
      ];
}
