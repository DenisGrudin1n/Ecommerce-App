part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({this.products = const []});

  final List<CartProduct> products;

  CartState copyWith({List<CartProduct>? products}) {
    return CartState(
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [products];
}
