import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsCategoriesModel {
  ItemsCategoriesModel({
    required this.name,
  });

  factory ItemsCategoriesModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return ItemsCategoriesModel(
      name: data['name'] as String? ?? '',
    );
  }
  final String name;
}
