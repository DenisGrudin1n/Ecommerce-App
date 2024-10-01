import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
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
    final favoriteProducts = context.select<FavoriteBloc, List<ProductModel>>(
      (bloc) => bloc.state.favoriteProducts,
    );

    if (favoriteProducts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('No favorite products.')),
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
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  blurRadius: 6,
                ),
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
