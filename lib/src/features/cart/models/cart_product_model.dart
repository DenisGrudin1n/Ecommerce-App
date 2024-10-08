import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  const CartProduct({
    required this.productName,
    required this.productPrice,
    required this.counter,
    required this.imageUrl,
  });

  final String productName;
  final double productPrice;
  final int counter;
  final String imageUrl;

  CartProduct copyWith({
    String? productName,
    double? productPrice,
    int? counter,
    String? imageUrl,
  }) {
    return CartProduct(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      counter: counter ?? this.counter,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object> get props => [productName, productPrice, counter, imageUrl];
}
