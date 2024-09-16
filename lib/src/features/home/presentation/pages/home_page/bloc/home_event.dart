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

// Events for Home Catalogue
class LoadHomeCatalogueEvent extends HomeEvent {}

// Events for Fashion Sale
class LoadFashionSaleImagesEvent extends HomeEvent {}
