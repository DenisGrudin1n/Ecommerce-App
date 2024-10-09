import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_product_model.g.dart';

@HiveType(typeId: 0)
class CartProduct extends Equatable {
  const CartProduct({
    required this.productName,
    required this.productPrice,
    required this.counter,
    required this.imageUrl,
  });

  @HiveField(0)
  final String productName;
  @HiveField(1)
  final double productPrice;
  @HiveField(2)
  final int counter;
  @HiveField(3)
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
