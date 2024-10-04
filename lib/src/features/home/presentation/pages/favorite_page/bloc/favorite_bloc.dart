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

  final Box<int> favoritesBox;

  void _onAddToFavorites(
    AddToFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    if (!state.favoriteProductsIds.contains(event.product.id)) {
      favoritesBox.add(event.product.id);
    }

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<int>().toList(),
      ),
    );
  }

  void _onRemoveFromFavorites(
    RemoveFromFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    favoritesBox.deleteAt(
      favoritesBox.values.cast<int>().toList().indexOf(event.product.id),
    );

    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<int>().toList(),
      ),
    );
  }

  void _onLoadFavoriteProducts(
    LoadFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.cast<int>().toList(),
      ),
    );
  }
}
