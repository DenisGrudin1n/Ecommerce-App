import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';

class FirestoreDatabaseRepository implements DatabaseRepository {
  FirestoreDatabaseRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<List<T>> fetchCollectionData<T>({
    required String collectionPath,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) fromSnapshot,
  }) async {
    try {
      final snapshot = await _firestore.collection(collectionPath).get();
      return snapshot.docs.map(fromSnapshot).toList();
    } catch (e) {
      log('Error fetching data from $collectionPath: $e');
      return [];
    }
  }

  @override
  Future<List<FeaturedProductModel>> getAllFeaturedProducts() {
    return fetchCollectionData<FeaturedProductModel>(
      collectionPath: 'home/featured/featuredProducts',
      fromSnapshot: FeaturedProductModel.fromSnapshot,
    );
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
          .startAt([query]).endAt(['$query\uf8ff']).get();
      return snapshot.docs.map(FeaturedProductModel.fromSnapshot).toList();
    } catch (e) {
      log('Error during search: $e');
      return [];
    }
  }

  @override
  Future<List<CatalogueModel>> getAllCatalogueItems() {
    return fetchCollectionData<CatalogueModel>(
      collectionPath: 'home/catalogue/catalogueCategories',
      fromSnapshot: CatalogueModel.fromSnapshot,
    );
  }

  @override
  Future<List<FashionSaleModel>> getAllFashionSaleImages() {
    return fetchCollectionData<FashionSaleModel>(
      collectionPath: 'home/fashion_sale/fashionSaleImages',
      fromSnapshot: FashionSaleModel.fromSnapshot,
    );
  }

  @override
  Future<List<CatalogueSubcategoriesModel>> getAllCatalogueSubcategories() {
    return fetchCollectionData<CatalogueSubcategoriesModel>(
      collectionPath: 'catalogue/catalogue/subcategories',
      fromSnapshot: CatalogueSubcategoriesModel.fromSnapshot,
    );
  }
}
