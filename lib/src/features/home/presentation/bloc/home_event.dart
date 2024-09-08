import 'package:ecommerce_app/src/features/home/presentation/bloc/home_state.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

// Events for Featured
class LoadFeaturedProductsEvent extends HomeEvent {
  const LoadFeaturedProductsEvent(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

// Events for Catalogue
class LoadCatalogueEvent extends HomeEvent {}

// Events for Fashion Sale
class LoadFashionSaleImagesEvent extends HomeEvent {}

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

// Events for bottombar navigation
class BottomNavEvent extends HomeEvent {
  const BottomNavEvent(this.tab);
  final BottomNavTab tab;

  @override
  List<Object> get props => [tab];
}
