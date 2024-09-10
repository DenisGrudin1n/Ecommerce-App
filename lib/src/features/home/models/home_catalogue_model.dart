import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCatalogueModel {
  HomeCatalogueModel({
    required this.name,
    required this.imageUrl,
  });

  factory HomeCatalogueModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return HomeCatalogueModel(
      name: data['name'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
  final String name;
  final String imageUrl;
}
