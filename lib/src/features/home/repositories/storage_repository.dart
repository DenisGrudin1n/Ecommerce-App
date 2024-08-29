import 'package:ecommerce_app/src/features/home/repositories/firebase_storage_repository.dart';

class StorageRepository {
  StorageRepository(this._firebaseStorageRepository);
  final FirebaseStorageRepository _firebaseStorageRepository;

  Future<String?> getDownloadURL(String imagePath) async {
    return _firebaseStorageRepository.getDownloadURL(imagePath);
  }

  Future<void> addImageURLToCollection(
    String documentPath,
    String imageField,
    String imageUrl,
  ) async {
    await _firebaseStorageRepository.addImageURLToFirestore(
      documentPath,
      imageField,
      imageUrl,
    );
  }
}
