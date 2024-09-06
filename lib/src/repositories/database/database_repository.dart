import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';

abstract class DatabaseRepository {
  Future<List<FeaturedProductModel>> searchFeaturedProducts(String query);
  Future<List<FeaturedProductModel>> getAllFeaturedProducts();
}
