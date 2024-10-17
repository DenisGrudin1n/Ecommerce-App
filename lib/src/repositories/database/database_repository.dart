import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:ecommerce_app/src/features/login/models/get_started_gif_model.dart';
import 'package:ecommerce_app/src/features/product/models/color_pic_model.dart';
import 'package:ecommerce_app/src/features/product/models/product_model.dart';

abstract class DatabaseRepository {
  Future<void> addFavorite(String userId, int productId);
  Future<void> removeFavorite(String userId, int productId);
  Stream<List<T>> fetchCollectionStream<T>({
    required String collectionPath,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) fromSnapshot,
  });
  Future<void> addProductToCart(String userId, CartProduct product);
  Future<void> removeProductFromCart(String userId, String imageUrl);
  Stream<List<CartProduct>> fetchCartProductsStream(String userId);
  Future<void> removeAllProductsFromCart(String userId);
  Future<List<GetStartedGifModel>> getAllGetStartedGifs();
  Future<List<ProductModel>> searchFeaturedProducts(String query);
  Future<List<CatalogueModel>> searchCatalogueItems(String query);
  Future<List<ProductModel>> searchItems(String query);
  Future<List<ProductModel>> getAllFeaturedProducts();
  Future<List<CatalogueModel>> getAllHomeCatalogueItems();
  Future<List<CatalogueModel>> getAllCatalogueItems();
  Future<List<ProductModel>> getAllItems();
  Future<List<ItemsCategoriesModel>> getAllItemsCategories();
  Future<List<FashionSaleModel>> getAllFashionSaleImages();
  Future<List<CatalogueSubcategoriesModel>> getAllCatalogueSubcategories();
  Future<List<BrandModel>> getAllBrands();
  Future<List<SizeModel>> getAllSizes();
  Future<List<SortByModel>> getAllSortBy();
  Future<List<AppbarProductModel>> getAllAppbarProducts();
  Future<List<AppbarColorPicModel>> getAllAppbarColorsPics();
}
