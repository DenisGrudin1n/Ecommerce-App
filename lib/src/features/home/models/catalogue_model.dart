import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogueModel {
  CatalogueModel({
    required this.name,
    required this.imageUrl,
  });

  factory CatalogueModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return CatalogueModel(
      name: data['name'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
  final String name;
  final String imageUrl;
}
