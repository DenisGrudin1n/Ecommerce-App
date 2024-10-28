part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartEvent extends CartEvent {
  const UpdateCartEvent(
    this.productName,
    this.productPrice,
    this.counter,
    this.imageUrl,
  );
  final String productName;
  final double productPrice;
  final int counter;
  final String imageUrl;
}

class IncrementCartCounterEvent extends CartEvent {
  const IncrementCartCounterEvent(this.imageUrl);
  final String imageUrl;
}

class DecrementCartCounterEvent extends CartEvent {
  const DecrementCartCounterEvent(this.imageUrl);
  final String imageUrl;
}

class LoadCartProductsEvent extends CartEvent {}

class RemoveAllCartProductsEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}
