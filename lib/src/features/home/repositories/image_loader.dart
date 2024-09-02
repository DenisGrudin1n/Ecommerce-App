import 'package:ecommerce_app/src/features/home/repositories/firebase_storage_repository.dart';
import 'package:ecommerce_app/src/features/home/repositories/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ImageLoader extends ChangeNotifier {
  final Logger logger = Logger();
  final StorageRepository storageRepository =
      StorageRepository(FirebaseStorageRepository());
  String? imageUrl;

  Future<void> loadImage(String path) async {
    final downloadURL = await storageRepository.getDownloadURL(path);

    if (downloadURL != null) {
      imageUrl = downloadURL;
      notifyListeners();
    } else {
      logger.e('Failed to load image');
    }
  }
}
