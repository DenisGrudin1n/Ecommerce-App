import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  Future<String?> getDownloadURL(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to get download URL: $e');
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
      print('Image URL added successfully to Firestore!');
    } catch (e) {
      print('Failed to add Image URL to Firestore: $e');
    }
  }
}
