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

class ChangeAppbarColorPicEvent extends ProductEvent {
  const ChangeAppbarColorPicEvent(this.colorPic);
  final String colorPic;

  @override
  List<Object?> get props => [colorPic];
}
