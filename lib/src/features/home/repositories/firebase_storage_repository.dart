import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class FirebaseStorageRepository {
  final Logger logger = Logger();

  Future<String?> getDownloadURL(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      logger.e('Failed to get download URL: $e');
      return null;
    }
  }

  Future<void> addImageURLToFirestore(
    String documentPath,
    String imageField,
    String imageUrl,
  ) async {
    try {
      final docRef = FirebaseFirestore.instance.doc(documentPath);
      await docRef.update({imageField: imageUrl});
      logger.e('Image URL added successfully to Firestore!');
    } catch (e) {
      logger.e('Failed to add Image URL to Firestore: $e');
    }
  }
}
