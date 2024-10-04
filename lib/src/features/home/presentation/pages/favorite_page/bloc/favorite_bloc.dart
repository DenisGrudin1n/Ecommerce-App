import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(this.favoritesBox) : super(const FavoriteState()) {
    on<AddToFavoriteEvent>(_onAddToFavorites);
    on<RemoveFromFavoriteEvent>(_onRemoveFromFavorites);
    on<LoadFavoriteProductsEvent>(_onLoadFavoriteProducts);
  }

  final Box<dynamic> favoritesBox;

  void _onAddToFavorites(
    AddToFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    if (!favoritesBox.values.contains(event.product)) {
      favoritesBox.add(event.product);
    }

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<ProductModel>().toList(),
      ),
    );
  }

  void _onRemoveFromFavorites(
    RemoveFromFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    final productToRemove = favoritesBox.values.cast<ProductModel>().firstWhere(
          (product) =>
              product.name == event.product.name &&
              product.price == event.product.price,
          orElse: () => ProductModel(name: '', price: '', imageUrl: ''),
        );

    favoritesBox.deleteAt(
      favoritesBox.values
          .cast<ProductModel>()
          .toList()
          .indexOf(productToRemove),
    );

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<ProductModel>().toList(),
      ),
    );
  }

  void _onLoadFavoriteProducts(
    LoadFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<ProductModel>().toList(),
      ),
    );
  }
}
