import 'package:equatable/equatable.dart';

abstract class CatalogueEvent extends Equatable {
  const CatalogueEvent();
  @override
  List<Object> get props => [];
}

// Events for Catalogue
class LoadCatalogueEvent extends CatalogueEvent {}

// Events for Catalogue Subcategories
class LoadCatalogueSubcategoriesEvent extends CatalogueEvent {}
