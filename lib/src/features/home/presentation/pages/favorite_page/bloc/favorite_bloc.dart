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

  final Box<String> favoritesBox;

  void _onAddToFavorites(
    AddToFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    // Check if the product name already exists in the favorites
    if (!state.favoriteProductsNames.contains(event.product.name)) {
      favoritesBox.add(event.product.name); // Add only the product name
    }

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<String>().toList(),
      ),
    );
  }

  void _onRemoveFromFavorites(
    RemoveFromFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    // Remove the product name
    favoritesBox.deleteAt(
      favoritesBox.values.cast<String>().toList().indexOf(event.product.name),
    );

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<String>().toList(),
      ),
    );
  }

  void _onLoadFavoriteProducts(
    LoadFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<String>().toList(),
      ),
    );
  }
}
