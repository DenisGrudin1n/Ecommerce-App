import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_model.dart';
import 'package:ecommerce_app/src/features/home/models/catalogue_subcategories_model.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:ecommerce_app/src/features/login/models/get_started_gif_model.dart';

abstract class DatabaseRepository {
  Future<List<GetStartedGifModel>> getAllGetStartedGifs();
  Future<List<FeaturedProductModel>> searchFeaturedProducts(String query);
  Future<List<CatalogueModel>> searchCatalogueItems(String query);
  Future<List<ItemsModel>> searchItems(String query);
  Future<List<FeaturedProductModel>> getAllFeaturedProducts();
  Future<List<CatalogueModel>> getAllHomeCatalogueItems();
  Future<List<CatalogueModel>> getAllCatalogueItems();
  Future<List<ItemsModel>> getAllItems();
  Future<List<ItemsCategoriesModel>> getAllItemsCategories();
  Future<List<FashionSaleModel>> getAllFashionSaleImages();
  Future<List<CatalogueSubcategoriesModel>> getAllCatalogueSubcategories();
  Future<List<BrandModel>> getAllBrands();
}
