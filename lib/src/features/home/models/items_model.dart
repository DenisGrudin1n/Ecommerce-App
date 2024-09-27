import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel {
  ItemsModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.oldPrice,
  });

  factory ItemsModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return ItemsModel(
      name: data['name'] as String? ?? '',
      price: data['price'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      oldPrice: data.data()?.containsKey('oldPrice') == true
          ? data['oldPrice'] as String?
          : null,
      imageUrl: data['imageUrl'] as String? ?? '',
      category: data['category'] as String? ?? '',
    );
  }
  final String name;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final String category;
}
