part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState({this.favoriteProductsNames = const []});
  final List<String> favoriteProductsNames;

  FavoriteState copyWith({List<String>? favoriteProducts}) {
    return FavoriteState(
      favoriteProductsNames: favoriteProducts ?? this.favoriteProductsNames,
    );
  }

  @override
  List<Object> get props => [favoriteProductsNames];
}
