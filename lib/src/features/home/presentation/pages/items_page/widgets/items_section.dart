import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/items_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_state.dart';
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
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        final items = state.items;
        final isLoading = state.isLoadingItems;
        final errorMessage = state.itemsErrorMessage;

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
          delegate: SliverChildListDelegate(
            [
              _buildHeader(context, filteredItems),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              _buildItemsGrid(filteredItems),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemsGrid(List<ItemsModel> items) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return _buildItemsTile(item, index);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildItemsTile(ItemsModel item, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
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
