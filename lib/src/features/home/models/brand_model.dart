import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  BrandModel({
    required this.name,
  });

  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return BrandModel(
      name: data['name'] as String? ?? '',
    );
  }
  final String name;
}
