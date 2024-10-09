import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/add_to_cart.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/product_appbar.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/product_details.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/product_reviews.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/related_products.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final favoritesBox = Hive.box<int>('favorites');
  final cartBox = Hive.box<CartProduct>('cart');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          )..add(LoadAppbarProductsEvent()),
        ),
        BlocProvider(
          create: (context) => ItemsBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          )..add(const LoadItemsEvent('')),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteBloc(favoritesBox)..add(LoadFavoriteProductsEvent()),
        ),
        BlocProvider(
          create: (context) => CartBloc(cartBox)..add(LoadCartProductsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: Stack(
          children: [
            // Scrollable content
            ListView(
              children: const [
                ProductAppbar(),
                SizedBox(
                  height: 8,
                ),
                ProductDetails(),
                SizedBox(
                  height: 8,
                ),
                ProductReviews(),
                SizedBox(
                  height: 8,
                ),
                RelatedProducts(),
              ],
            ),
            // Fixed AddToCart button
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AddToCart(),
            ),
          ],
        ),
      ),
    );
  }
}
