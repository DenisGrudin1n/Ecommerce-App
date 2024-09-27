import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:ecommerce_app/src/features/login/models/get_started_gif_model.dart';
import 'package:ecommerce_app/src/features/product/models/color_pic_model.dart';
import 'package:ecommerce_app/src/features/product/models/product_model.dart';
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
  Future<List<FeaturedProductModel>> searchFeaturedProducts(
    String query,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('home')
          .doc('featured')
          .collection('featuredProducts')
          .orderBy('name')
          .get();

      final regex = RegExp(query, caseSensitive: false);
      final filteredProducts = snapshot.docs
          .where((doc) {
            final name = doc['name'] as String?;
            return name != null && regex.hasMatch(name);
          })
          .map(FeaturedProductModel.fromSnapshot)
          .toList();
      return filteredProducts;
    } catch (e) {
      log('Error during search: $e');
      return [];
    }
  }

  @override
  Future<List<CatalogueModel>> searchCatalogueItems(
    String query,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('home')
          .doc('catalogue')
          .collection('catalogueCategories')
          .orderBy('name')
          .get();
      final regex = RegExp(query, caseSensitive: false);
      final filteredProducts = snapshot.docs
          .where((doc) {
            final name = doc['name'] as String?;
            return name != null && regex.hasMatch(name);
          })
          .map(CatalogueModel.fromSnapshot)
          .toList();
      return filteredProducts;
    } catch (e) {
      log('Error during search: $e');
      return [];
    }
  }

  @override
  Future<List<ItemsModel>> searchItems(
    String query,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('catalogue')
          .doc('catalogue')
          .collection('items')
          .orderBy('name')
          .get();
      final regex = RegExp(query, caseSensitive: false);
      final filteredProducts = snapshot.docs
          .where((doc) {
            final name = doc['name'] as String?;
            return name != null && regex.hasMatch(name);
          })
          .map(ItemsModel.fromSnapshot)
          .toList();
      return filteredProducts;
    } catch (e) {
      log('Error during search: $e');
      return [];
    }
  }

  @override
  Future<List<GetStartedGifModel>> getAllGetStartedGifs() {
    return fetchCollectionData<GetStartedGifModel>(
      collectionPath: 'getStarted/gifs/gifs',
      fromSnapshot: GetStartedGifModel.fromSnapshot,
    );
  }

  @override
  Future<List<CatalogueModel>> getAllHomeCatalogueItems() {
    return fetchCollectionData<CatalogueModel>(
      collectionPath: 'home/catalogue/catalogueCategories',
      fromSnapshot: CatalogueModel.fromSnapshot,
    );
  }

  @override
  Future<List<FeaturedProductModel>> getAllFeaturedProducts() {
    return fetchCollectionData<FeaturedProductModel>(
      collectionPath: 'home/featured/featuredProducts',
      fromSnapshot: FeaturedProductModel.fromSnapshot,
    );
  }

  @override
  Future<List<CatalogueModel>> getAllCatalogueItems() {
    return fetchCollectionData<CatalogueModel>(
      collectionPath: 'catalogue/categories/catalogueCategories',
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
      collectionPath: 'catalogue/subcategories/subcategories',
      fromSnapshot: CatalogueSubcategoriesModel.fromSnapshot,
    );
  }

  @override
  Future<List<ItemsModel>> getAllItems() {
    return fetchCollectionData<ItemsModel>(
      collectionPath: 'catalogue/catalogue/items',
      fromSnapshot: ItemsModel.fromSnapshot,
    );
  }

  @override
  Future<List<ItemsCategoriesModel>> getAllItemsCategories() {
    return fetchCollectionData<ItemsCategoriesModel>(
      collectionPath: 'catalogue/catalogue/itemsCategories',
      fromSnapshot: ItemsCategoriesModel.fromSnapshot,
    );
  }

  @override
  Future<List<BrandModel>> getAllBrands() {
    return fetchCollectionData<BrandModel>(
      collectionPath: 'catalogue/catalogue/filters/brands/brands',
      fromSnapshot: BrandModel.fromSnapshot,
    );
  }

  @override
  Future<List<SizeModel>> getAllSizes() {
    return fetchCollectionData<SizeModel>(
      collectionPath: 'catalogue/catalogue/filters/sizes/sizes',
      fromSnapshot: SizeModel.fromSnapshot,
    );
  }

  @override
  Future<List<SortByModel>> getAllSortBy() {
    return fetchCollectionData<SortByModel>(
      collectionPath: 'catalogue/catalogue/filters/sortBy/sortBy',
      fromSnapshot: SortByModel.fromSnapshot,
    );
  }

  @override
  Future<List<AppbarProductModel>> getAllAppbarProducts() {
    return fetchCollectionData<AppbarProductModel>(
      collectionPath: 'product/appbar/appbar',
      fromSnapshot: AppbarProductModel.fromSnapshot,
    );
  }

  @override
  Future<List<AppbarColorPicModel>> getAllAppbarColorsPics() {
    return fetchCollectionData<AppbarColorPicModel>(
      collectionPath: 'product/appbar/appbarColorsPics',
      fromSnapshot: AppbarColorPicModel.fromSnapshot,
    );
  }
}
