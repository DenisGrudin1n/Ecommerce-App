part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState({this.favoriteProductsIds = const []});
  final List<int> favoriteProductsIds;

  FavoriteState copyWith({List<int>? favoriteProducts}) {
    return FavoriteState(
      favoriteProductsIds: favoriteProducts ?? favoriteProductsIds,
    );
  }

  @override
  List<Object> get props => [favoriteProductsIds];
}
