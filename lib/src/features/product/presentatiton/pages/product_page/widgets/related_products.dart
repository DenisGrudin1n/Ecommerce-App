import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProducts extends StatefulWidget {
  const RelatedProducts({super.key});

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(const LoadItemsEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    final items = context.select<ItemsBloc, List<ItemsModel>>(
      (bloc) => bloc.state.items,
    );
    final isLoading = context.select<ItemsBloc, bool>(
      (bloc) => bloc.state.isLoadingItems,
    );
    final isProductFavorite = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isProductFavorite,
    );
    final errorMessage = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.itemsErrorMessage,
    );

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Text(errorMessage);
    }

    if (items.isEmpty) {
      return Center(
        child: Text(context.localization.noItemsFoundForQueryText),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 140,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products related to this item',
            style: HomePageTextStyles.homePageFeaturedTextStyle,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 235,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if (index != 1) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index != items.length - 1 ? 16 : 0,
                    ),
                    child: _buildItemsTile(
                      item,
                      index,
                      isProductFavorite,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTile(ItemsModel item, int index, bool isProductFavorite) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 140,
            decoration: BoxDecoration(
              color: AppColors.lightBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: item.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.contain,
                          )
                        : null,
                    color: AppColors.whiteColor,
                  ),
                  child: item.imageUrl.isEmpty
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
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      HomePageTextStyles.homePageFeaturedProductNameTextStyle,
                ),
                const SizedBox(height: 6),
                // Price Section
                Text(
                  '\$${item.price}',
                  style: HomePageTextStyles
                      .homePageFeaturedProductDarkPriceTextStyle,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
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
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // context.read<ProductBloc>().add(ToggleProductFavoriteEvent());
                },
                icon: index == 2
                    ? AppIcons.smallFavoriteProductIcon
                    : const GradientIcon(
                        icon: Icons.favorite_border,
                        size: 20,
                        gradient: AppGradients.purpleGradient,
                        strokeWidth: 1,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
