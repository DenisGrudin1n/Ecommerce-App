import 'package:equatable/equatable.dart';

abstract class CatalogueEvent extends Equatable {
  const CatalogueEvent();
  @override
  List<Object> get props => [];
}

// Events for Catalogue
class LoadCatalogueItemsEvent extends CatalogueEvent {
  const LoadCatalogueItemsEvent(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

// Events for Catalogue Subcategories
class LoadCatalogueSubcategoriesEvent extends CatalogueEvent {}
