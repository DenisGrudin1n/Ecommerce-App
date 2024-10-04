import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
    this.category,
  });

  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return ProductModel(
      name: data['name'] as String? ?? '',
      price: data['price'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      oldPrice: data.data()?.containsKey('oldPrice') == true
          ? data['oldPrice'] as String?
          : null,
      imageUrl: data['imageUrl'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      category: data.data()?.containsKey('category') == true
          ? data['category'] as String?
          : null,
    );
  }

  @override
  String toString() {
    return 'FeaturedProductModel(name: $name, price: $price, category: $category)';
  }

  final String name;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final String? category;
}
