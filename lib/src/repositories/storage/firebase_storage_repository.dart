import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class FirebaseStorageRepository implements StorageRepository {
  FirebaseStorageRepository(this._firebaseStorage);
  final FirebaseStorage _firebaseStorage;

  final Logger logger = Logger();

  @override
  Future<String?> getDownloadURL(String imagePath) async {
    try {
      final ref = _firebaseStorage.ref().child(imagePath);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      logger.e('Failed to get download URL: $e');
      return null;
    }
  }
}
