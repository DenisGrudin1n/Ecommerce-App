import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppbarProductsEvent extends ProductEvent {}

class LoadAppbarSizesEvent extends ProductEvent {}

class ChangeAppbarSizeEvent extends ProductEvent {
  const ChangeAppbarSizeEvent(this.size);
  final String size;

  @override
  List<Object?> get props => [size];
}

class LoadAppbarColorsPicsEvent extends ProductEvent {}

class ChangeColorPicEvent extends ProductEvent {
  const ChangeColorPicEvent(this.colorPic, this.selectedImageUrl);
  final String colorPic;
  final String selectedImageUrl;

  @override
  List<Object?> get props => [colorPic, selectedImageUrl];
}

class ToggleCommentHelpfulEvent extends ProductEvent {}

class ToggleCartSizeEvent extends ProductEvent {}

class ToggleProductFavoriteEvent extends ProductEvent {}

class IncrementCounterEvent extends ProductEvent {}

class DecrementCounterEvent extends ProductEvent {}
