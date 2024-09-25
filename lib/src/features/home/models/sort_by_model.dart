import 'package:cloud_firestore/cloud_firestore.dart';

class SortByModel {
  SortByModel({
    required this.name,
  });

  factory SortByModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return SortByModel(
      name: data['name'] as String? ?? '',
    );
  }
  final String name;
}
