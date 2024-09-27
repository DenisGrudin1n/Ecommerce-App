import 'package:cloud_firestore/cloud_firestore.dart';

class AppbarColorPicModel {
  AppbarColorPicModel({
    required this.imageUrl,
  });

  factory AppbarColorPicModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return AppbarColorPicModel(
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
  final String imageUrl;
}
