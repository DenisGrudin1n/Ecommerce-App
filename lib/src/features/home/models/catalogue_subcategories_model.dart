import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogueSubcategoriesModel {
  CatalogueSubcategoriesModel({
    required this.name,
  });

  factory CatalogueSubcategoriesModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return CatalogueSubcategoriesModel(
      name: data['name'] as String? ?? '',
    );
  }

  final String name;
}
