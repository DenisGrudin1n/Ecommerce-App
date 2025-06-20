import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc({
    required this.storageRepository,
    required this.firestoreRepository,
  }) : super(const ItemsState()) {
    on<LoadItemsEvent>(_onLoadItemsChanged);
    on<LoadItemsCategoriesEvent>(_onLoadItemsCategoriesChanged);
    on<ChangeItemsCategoryEvent>(_onItemsCategoryChanged);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;

  Future<void> _onLoadItemsChanged(
    LoadItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    final query = event.query;
    emit(state.copyWith(isLoadingItems: true, itemsErrorMessage: ''));

    try {
      final filteredProducts = query.isEmpty
          ? await firestoreRepository.getAllItems()
          : await firestoreRepository.searchItems(query);
      emit(
        state.copyWith(
          items: filteredProducts,
          isLoadingItems: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          itemsErrorMessage: e.toString(),
          isLoadingItems: false,
        ),
      );
    }
  }

  Future<void> _onLoadItemsCategoriesChanged(
    LoadItemsCategoriesEvent event,
    Emitter<ItemsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingItemsCategories: true,
        itemsCategoriesErrorMessage: '',
      ),
    );

    try {
      final categories = await firestoreRepository.getAllItemsCategories();
      emit(
        state.copyWith(
          itemsCategories: categories,
          isLoadingItemsCategories: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          itemsCategoriesErrorMessage: e.toString(),
          isLoadingItemsCategories: false,
        ),
      );
    }
  }

  Future<void> _onItemsCategoryChanged(
    ChangeItemsCategoryEvent event,
    Emitter<ItemsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingItems: true,
        selectedCategory: event.selectedCategory,
      ),
    );

    List<ProductModel> filteredItems;
    try {
      if (event.selectedCategory == 'All') {
        final allItems = await firestoreRepository.getAllItems();
        filteredItems = allItems;
      } else {
        filteredItems = state.items
            .where((item) => item.category == event.selectedCategory)
            .toList();

        // If filtering returns an empty list, load all products once more
        if (filteredItems.isEmpty) {
          final allItems = await firestoreRepository.getAllItems();
          filteredItems = allItems
              .where((item) => item.category == event.selectedCategory)
              .toList();
        }
      }

      emit(
        state.copyWith(
          items: filteredItems,
          isLoadingItems: false,
          itemsErrorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingItems: false,
          itemsErrorMessage: e.toString(),
        ),
      );
    }
  }
}
