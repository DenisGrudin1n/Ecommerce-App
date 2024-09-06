import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

// Events for Search
class LoadFeaturedProductsEvent extends HomeEvent {
  const LoadFeaturedProductsEvent(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

// Events for Images
class LoadImageEvent extends HomeEvent {
  const LoadImageEvent({required this.imagePath});
  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class LoadImagesEvent extends HomeEvent {
  const LoadImagesEvent({required this.imagePaths});
  final List<String> imagePaths;

  @override
  List<Object> get props => [imagePaths];
}
