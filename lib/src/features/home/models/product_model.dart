import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
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

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String? oldPrice;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String? category;
}
