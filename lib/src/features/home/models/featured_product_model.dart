import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String name;
  final String price;
  final String? oldPrice;
  final String imageUrl;
}
