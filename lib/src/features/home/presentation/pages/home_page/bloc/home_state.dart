import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  Map<String, String> get imageUrls => const {};
  @override
  List<Object> get props => [];
}

// States for Search
//class SearchInitialState extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {
  const SearchSuccessState(this.products);
  final List<FeaturedProductModel> products;

  @override
  List<Object> get props => [products];
}

class SearchErrorState extends HomeState {
  const SearchErrorState(this.message);
  final String message;
}

// States for Images
class ImageLoaderInitialState extends HomeState {
  const ImageLoaderInitialState({this.imageUrls = const {}});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadingState extends HomeState {
  const ImageLoadingState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadedState extends HomeState {
  const ImageLoadedState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoadFailureState extends HomeState {
  const ImageLoadFailureState({required this.imageUrls});
  @override
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}
