import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:equatable/equatable.dart';

class ItemsState extends Equatable {
  const ItemsState({
    this.items = const [],
    this.itemsCategories = const [],
    this.isLoadingItems = false,
    this.isLoadingItemsCategories = false,
    this.selectedCategory = 'All',
    this.itemsErrorMessage = '',
    this.itemsCategoriesErrorMessage = '',
  });

  final List<ItemsModel> items;
  final List<ItemsCategoriesModel> itemsCategories;
  final String selectedCategory;

  // Loading states for each section
  final bool isLoadingItems;
  final bool isLoadingItemsCategories;

  // Error messages for each section
  final String itemsErrorMessage;
  final String itemsCategoriesErrorMessage;

  ItemsState copyWith({
    List<ItemsModel>? items,
    List<ItemsCategoriesModel>? itemsCategories,
    bool? isLoadingItems,
    bool? isLoadingItemsCategories,
    String? selectedCategory,
    String? itemsErrorMessage,
    String? itemsCategoriesErrorMessage,
  }) {
    return ItemsState(
      items: items ?? this.items,
      itemsCategories: itemsCategories ?? this.itemsCategories,
      isLoadingItems: isLoadingItems ?? this.isLoadingItems,
      isLoadingItemsCategories:
          isLoadingItemsCategories ?? this.isLoadingItemsCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      itemsErrorMessage: itemsErrorMessage ?? this.itemsErrorMessage,
      itemsCategoriesErrorMessage:
          itemsCategoriesErrorMessage ?? this.itemsCategoriesErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        items,
        itemsCategories,
        isLoadingItems,
        isLoadingItemsCategories,
        selectedCategory,
        itemsErrorMessage,
        itemsCategoriesErrorMessage,
      ];
}
