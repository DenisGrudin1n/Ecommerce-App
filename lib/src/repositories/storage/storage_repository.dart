// ignore: one_member_abstracts
abstract interface class StorageRepository {
  Future<String?> getDownloadURL(String imagePath);
}
