import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.brand,
    this.colors,
    this.sizes,
    this.oldPrice,
    this.category,
  });

  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return ProductModel(
      id: data['id'] as int? ?? -1,
      name: data['name'] as String? ?? '',
      price: data['price'] as String? ?? '',
      // ignore: use_if_null_to_convert_nulls_to_bools
      oldPrice: data.data()?.containsKey('oldPrice') == true
          ? data['oldPrice'] as String?
          : null,
      imageUrl: data['imageUrl'] as String? ?? '',

      // ignore: use_if_null_to_convert_nulls_to_bools
      brand: data.data()?.containsKey('brand') == true
          ? data['brand'] as String?
          : null,

      // ignore: use_if_null_to_convert_nulls_to_bools
      colors: data.data()?.containsKey('colors') == true
          ? List<String>.from(data['colors'] as List<dynamic>)
          : null,

      // ignore: use_if_null_to_convert_nulls_to_bools
      sizes: data.data()?.containsKey('sizes') == true
          ? List<String>.from(data['sizes'] as List<dynamic>)
          : null,

      // ignore: use_if_null_to_convert_nulls_to_bools
      category: data.data()?.containsKey('category') == true
          ? data['category'] as String?
          : null,
    );
  }

  final int id;
  final String name;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final String? category;
  final String? brand;
  final List<String>? colors;
  final List<String>? sizes;
}
