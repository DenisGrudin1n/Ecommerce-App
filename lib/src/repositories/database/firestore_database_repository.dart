import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';

class FirestoreDatabaseRepository implements DatabaseRepository {
  FirestoreDatabaseRepository(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<List<FeaturedProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('home')
          .doc('featured')
          .collection('featuredProducts')
          .get();
      return snapshot.docs.map(FeaturedProductModel.fromSnapshot).toList();
    } catch (e) {
      log('Error fetching products: $e');
      return [];
    }
  }

  @override
  Future<List<FeaturedProductModel>> searchFeaturedProducts(
    String query,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('home')
          .doc('featured')
          .collection('featuredProducts')
          .orderBy('name')
          .startAt([query]).endAt(['$query\uf8ff']) // Partial match query
          .get();

      return snapshot.docs.map(FeaturedProductModel.fromSnapshot).toList();
    } catch (e) {
      log('Error during search: $e');
      return [];
    }
  }
}
