part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddToFavoriteEvent extends FavoriteEvent {
  const AddToFavoriteEvent(this.product);
  final ProductModel product;

  @override
  List<Object> get props => [product];
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  const RemoveFromFavoriteEvent(this.product);
  final ProductModel product;

  @override
  List<Object> get props => [product];
}

class LoadFavoriteProductsEvent extends FavoriteEvent {}
