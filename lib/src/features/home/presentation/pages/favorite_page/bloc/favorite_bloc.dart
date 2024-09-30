import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
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

  final Box<FeaturedProductModel> favoritesBox;

  void _onAddToFavorites(
    AddToFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    favoritesBox.add(event.product);
    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.toList(),
      ),
    );
  }

  void _onRemoveFromFavorites(
    RemoveFromFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) {
    final index = favoritesBox.values.toList().indexOf(event.product);
    if (index != -1) {
      favoritesBox.deleteAt(index);
    }
    emit(
      state.copyWith(
        favoriteProducts: favoritesBox.values.toList(),
      ),
    ); // Add the LoadFavoriteProductsEvent
  }

  void _onLoadFavoriteProducts(
    LoadFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(state.copyWith(favoriteProducts: favoritesBox.values.toList()));
  }
}
