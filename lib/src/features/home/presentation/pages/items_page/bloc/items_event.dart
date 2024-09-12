import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
  @override
  List<Object> get props => [];
}

// Events for Items
class LoadItemsEvent extends ItemsEvent {
  const LoadItemsEvent(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

class LoadItemsCategoriesEvent extends ItemsEvent {}
