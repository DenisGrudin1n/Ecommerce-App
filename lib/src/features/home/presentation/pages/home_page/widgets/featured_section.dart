import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedSection extends StatefulWidget {
  const FeaturedSection({
    super.key,
  });

  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadFeaturedProductsEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    final featuredSectionProducts =
        context.select<HomeBloc, List<FeaturedProductModel>>(
      (bloc) => bloc.state.featuredProducts,
    );
    final isLoading = context.select<HomeBloc, bool>(
      (bloc) => bloc.state.isLoadingFeatured,
    );
    final errorMessage = context.select<HomeBloc, String>(
      (bloc) => bloc.state.featuredErrorMessage,
    );

    if (isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return SliverToBoxAdapter(
        child: Text(errorMessage),
      );
    }

    if (featuredSectionProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Text(context.localization.noItemsFoundForQueryText),
      );
    }

    return _buildProductGrid(featuredSectionProducts);
  }

  Widget _buildProductGrid(List<FeaturedProductModel> products) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final product = products[index];
          return _buildFeaturedProductTile(product, index);
        },
        childCount: products.length,
      ),
    );
  }

  Widget _buildFeaturedProductTile(FeaturedProductModel product, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
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
                    (starIndex) => const Icon(
                      Icons.star,
                      color: AppColors.orangeColor,
                      size: 12,
                    ),
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
            padding: const EdgeInsets.all(6),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: index != 1
                ? const GradientIcon(
                    icon: Icons.favorite_border,
                    size: 20,
                    gradient: AppGradients.purpleGradient,
                    strokeWidth: 1,
                  )
                : const Icon(
                    Icons.favorite,
                    size: 20,
                    color: AppColors.yellowColor,
                  ),
          ),
        ),
        if (index == 0)
          // Discount Label Positioned
          Positioned(
            top: 8,
            left: 0,
            child: Container(
              height: 20,
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: AppGradients.orangeGradient,
              ),
              child: Center(
                child: Text(
                  '-50%',
                  style: HomePageTextStyles
                      .homePageFeaturedDiscountPercentTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
