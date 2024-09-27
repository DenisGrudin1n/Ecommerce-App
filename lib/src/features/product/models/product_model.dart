import 'package:cloud_firestore/cloud_firestore.dart';

class AppbarProductModel {
  AppbarProductModel({
    required this.name,
    required this.price,
    required this.imageUrls,
    this.oldPrice,
  });

  factory AppbarProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return AppbarProductModel(
      name: data['name'] as String? ?? '',
      price: data['price'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      oldPrice: data.data()?.containsKey('oldPrice') == true
          ? data['oldPrice'] as String?
          : null,
      imageUrls: (data['imageUrls'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
    );
  }
  final String name;
  final String price;
  final String? oldPrice;
  final List<String> imageUrls;
}
