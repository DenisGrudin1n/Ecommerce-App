import 'package:cloud_firestore/cloud_firestore.dart';

class SizeModel {
  SizeModel({
    required this.name,
  });

  factory SizeModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return SizeModel(
      name: data['name'] as String? ?? '',
    );
  }
  final String name;
}
