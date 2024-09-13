import 'package:cloud_firestore/cloud_firestore.dart';

class GetStartedGifModel {
  GetStartedGifModel({
    required this.imageUrl,
  });

  factory GetStartedGifModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return GetStartedGifModel(
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
  final String imageUrl;
}
