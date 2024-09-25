import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsSection extends StatefulWidget {
  const ItemsSection({
    required this.selectedCategory,
    super.key,
  });
  final String selectedCategory;

  @override
  State<ItemsSection> createState() => _ItemsSectionState();
}

class _ItemsSectionState extends State<ItemsSection> {
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
    final errorMessage = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.itemsErrorMessage,
    );

    final filteredItems = widget.selectedCategory == 'All'
        ? items
        : items
            .where((item) => item.category == widget.selectedCategory)
            .toList();

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

    if (filteredItems.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(context.localization.noItemsFoundForQueryText),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return _buildHeader(context, filteredItems);
          }

          final itemIndex = (index - 1) * 2;

          if (itemIndex < filteredItems.length) {
            final firstItem = filteredItems[itemIndex];
            final secondItem = itemIndex + 1 < filteredItems.length
                ? filteredItems[itemIndex + 1]
                : null;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _buildItemsTile(firstItem, itemIndex),
                  ),
                  const SizedBox(width: 16),
                  if (secondItem != null)
                    Expanded(
                      child: _buildItemsTile(secondItem, itemIndex + 1),
                    )
                  else
                    Expanded(
                      child: Container(),
                    ),
                ],
              ),
            );
          }
          return null;
        },
        childCount: (filteredItems.length / 2).ceil() + 1,
      ),
    );
  }

  Widget _buildItemsTile(ItemsModel item, int index) {
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
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      HomePageTextStyles.homePageFeaturedProductNameTextStyle,
                ),
                const SizedBox(height: 6),
                // Price Section
                if (item.oldPrice != null && item.oldPrice!.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        '\$${item.price}',
                        style: HomePageTextStyles
                            .homePageFeaturedProductRedPriceTextStyle,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${item.oldPrice}',
                        style: HomePageTextStyles
                            .homePageFeaturedProductGreyPriceTextStyle,
                      ),
                    ],
                  )
                else
                  Text(
                    '\$${item.price}',
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

  Widget _buildHeader(BuildContext context, List<ItemsModel> items) {
    return Row(
      children: [
        Text(
          '${items.length} ${context.localization.itemsPageItemsText}',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            color: AppColors.darkColor,
            height: 23 / 19,
            letterSpacing: -0.49,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              context.localization.itemsPageSortByText,
              style: ItemsPageTextStyles.sortByTextStyle,
            ),
            Text(
              context.localization.itemsPageFeaturedText,
              style: ItemsPageTextStyles.featuredTextStyle,
            ),
            AppIcons.itemsSectionFeaturedIcon,
          ],
        ),
      ],
    );
  }
}
