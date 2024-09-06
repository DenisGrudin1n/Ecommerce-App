import 'package:cloud_firestore/cloud_firestore.dart';

class FashionSaleModel {
  FashionSaleModel({
    required this.imageUrl,
  });

  factory FashionSaleModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return FashionSaleModel(
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
  final String imageUrl;
}
