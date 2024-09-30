import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'featured_product_model.g.dart';

@HiveType(typeId: 0)
class FeaturedProductModel {
  FeaturedProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
  });

  factory FeaturedProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return FeaturedProductModel(
      name: data['name'] as String? ?? '',
      price: data['price'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      oldPrice: data.data()?.containsKey('oldPrice') == true
          ? data['oldPrice'] as String?
          : null,
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'FeaturedProductModel(name: $name, price: $price)';
  }

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String? oldPrice;
  @HiveField(3)
  final String imageUrl;
}
