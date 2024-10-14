import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/shadows.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSection extends StatefulWidget {
  const FavoriteSection({super.key});

  @override
  State<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavoriteProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProductsIds = context.select<FavoriteBloc, List<int>>(
      (bloc) => bloc.state.favoriteProductsIds,
    );

    // Select featured products from HomeBloc
    final featuredProducts = context.select<HomeBloc, List<ProductModel>>(
      (bloc) => bloc.state.featuredProducts,
    );

    // Select items from ItemsBloc
    final itemsProducts = context.select<ItemsBloc, List<ProductModel>>(
      (bloc) => bloc.state.items,
    );

    // Combine featured products and items while avoiding duplicates
    final allProducts = [...featuredProducts];
    // Add items only if they are not already in featuredProducts
    for (final item in itemsProducts) {
      if (!allProducts.any((product) => product.name == item.name)) {
        allProducts.add(item);
      }
    }

    // Filter to find favorite products
    final favoriteProducts = allProducts
        .where((product) => favoriteProductsIds.contains(product.id))
        .toList();

    if (favoriteProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            context.localization.favoritePageNoProductsText,
          ),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final product = favoriteProducts[index];
          return _buildFavoriteProductTile(product, context);
        },
        childCount: favoriteProducts.length,
      ),
    );
  }

  Widget _buildFavoriteProductTile(
    ProductModel product,
    BuildContext context,
  ) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.router.push(const ProductRoute());
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: product.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.contain,
                          )
                        : null,
                    color: AppColors.whiteColor,
                  ),
                  child: product.imageUrl.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                // Star Ratings
                Row(
                  children: List.generate(
                    5,
                    (starIndex) => AppIcons.starIcon,
                  ),
                ),
                const SizedBox(height: 8),
                // Product Name
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      HomePageTextStyles.homePageFeaturedProductNameTextStyle,
                ),
                const SizedBox(height: 6),
                // Price Section
                if (product.oldPrice != null && product.oldPrice!.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: HomePageTextStyles
                            .homePageFeaturedProductRedPriceTextStyle,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${product.oldPrice}',
                        style: HomePageTextStyles
                            .homePageFeaturedProductGreyPriceTextStyle,
                      ),
                    ],
                  )
                else
                  Text(
                    '\$${product.price}',
                    style: HomePageTextStyles
                        .homePageFeaturedProductDarkPriceTextStyle,
                  ),
              ],
            ),
          ),
        ),

        // Favorite Icon Positioned
        Positioned(
          top: 152,
          right: 8,
          child: Container(
            padding: EdgeInsets.zero,
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                AppShadows.favoriteIconBoxShadow,
              ],
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context
                      .read<FavoriteBloc>()
                      .add(RemoveFromFavoriteEvent(product));
                },
                icon: AppIcons.smallFavoriteProductIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
