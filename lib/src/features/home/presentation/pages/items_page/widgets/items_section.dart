import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/shadows.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsSection extends StatefulWidget {
  const ItemsSection({
    super.key,
  });

  @override
  State<ItemsSection> createState() => _ItemsSectionState();
}

class _ItemsSectionState extends State<ItemsSection> {
  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(const LoadItemsEvent(''));
    context.read<ItemsBloc>().add(LoadItemsSortByEvent());
    context.read<FavoriteBloc>().add(LoadFavoriteProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final items = context.select<ItemsBloc, List<ProductModel>>(
      (bloc) => bloc.state.items,
    );
    final isLoading = context.select<ItemsBloc, bool>(
      (bloc) => bloc.state.isLoadingItems,
    );
    final errorMessage = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.itemsErrorMessage,
    );
    final favoriteProductsIds = context.select<FavoriteBloc, List<int>>(
      (bloc) => bloc.state.favoriteProductsIds,
    );

    final minPrice = context.select<FilterBloc, double>(
      (bloc) => bloc.state.minValue,
    );
    final maxPrice = context.select<FilterBloc, double>(
      (bloc) => bloc.state.maxValue,
    );
    final selectedBrands = context.select<FilterBloc, List<String>>(
      (bloc) => bloc.state.selectedBrands,
    );
    final selectedColors = context.select<FilterBloc, Map<String, Color>>(
      (bloc) => bloc.state.selectedColors,
    );
    final selectedCategory = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );
    final selectedSizes = context.select<FilterBloc, List<String>>(
      (bloc) => bloc.state.selectedSizes,
    );
    final selectedSortBy = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.selectedSortBy,
    );

    final isDropDownOpen = context.select<ItemsBloc, bool>(
      (bloc) => bloc.state.isSortByDropdownOpen,
    );
    final sortBy = context.select<ItemsBloc, List<SortByModel>>(
      (bloc) => bloc.state.sortBy,
    );

    final filteredItems = items.where((item) {
      final isInPriceRange = double.parse(item.price) > minPrice &&
          double.parse(item.price) < maxPrice;

      final isInSelectedCategory =
          selectedCategory == 'All' || item.category == selectedCategory;

      final isBrandSelected = selectedBrands.contains(item.brand);

      final isColorSelected = selectedColors.isEmpty ||
          item.colors!.any(selectedColors.containsKey);

      final hasSelectedSize =
          selectedSizes.isEmpty || item.sizes!.any(selectedSizes.contains);

      return isInPriceRange &&
          isInSelectedCategory &&
          (selectedBrands.contains('All') || isBrandSelected) &&
          isColorSelected &&
          hasSelectedSize;
    }).toList();

    if (selectedSortBy.isNotEmpty && selectedSortBy != 'Featured') {
      if (selectedSortBy == 'Lowest Price') {
        filteredItems.sort(
          (a, b) => double.parse(a.price).compareTo(double.parse(b.price)),
        );
      } else if (selectedSortBy == 'Highest Price') {
        filteredItems.sort(
          (a, b) => double.parse(b.price).compareTo(double.parse(a.price)),
        );
      }
    }

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
            return _buildHeader(
              context,
              filteredItems,
              isDropDownOpen,
              sortBy,
              selectedSortBy,
            );
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
                    child: _buildItemsTile(
                      firstItem,
                      itemIndex,
                      favoriteProductsIds,
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (secondItem != null)
                    Expanded(
                      child: _buildItemsTile(
                        secondItem,
                        itemIndex + 1,
                        favoriteProductsIds,
                      ),
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

  Widget _buildItemsTile(
    ProductModel item,
    int index,
    List<int> favoriteProductsNames,
  ) {
    final isFavorite = favoriteProductsNames.contains(item.id);

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
                  if (isFavorite) {
                    context
                        .read<FavoriteBloc>()
                        .add(RemoveFromFavoriteEvent(item));
                  } else {
                    context.read<FavoriteBloc>().add(AddToFavoriteEvent(item));
                  }
                },
                icon: isFavorite
                    ? AppIcons.smallFavoriteProductIcon
                    : AppIcons.notFavoriteGradientIcon,
              ),
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

  Widget _buildHeader(
    BuildContext context,
    List<ProductModel> items,
    bool isDropDownOpen,
    List<SortByModel> sortBy,
    String selectedSortBy,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '${items.length} ${context.localization.itemsPageItemsText}',
                  style: ItemsPageTextStyles.itemsTextStyle,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                context.read<ItemsBloc>().add(ToggleItemsSortByDropdownEvent());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        context.localization.itemsPageSortByText,
                        style: ItemsPageTextStyles.sortByTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            selectedSortBy.isNotEmpty
                                ? selectedSortBy
                                : context.localization.itemsPageFeaturedText,
                            style: ItemsPageTextStyles.featuredTextStyle,
                          ),
                          const SizedBox(width: 4),
                          AppIcons.itemsSectionFeaturedIcon,
                        ],
                      ),
                      if (isDropDownOpen) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: sortBy.map((option) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<ItemsBloc>()
                                    .add(ChangeItemsSortByEvent(option.name));
                                context
                                    .read<ItemsBloc>()
                                    .add(ToggleItemsSortByDropdownEvent());
                                context
                                    .read<FilterBloc>()
                                    .add(ChangeSortByEvent(option.name));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      option.name,
                                      style:
                                          ItemsPageTextStyles.featuredTextStyle,
                                    ),
                                    const SizedBox(width: 4),
                                    if (selectedSortBy == option.name)
                                      const Icon(
                                        Icons.circle,
                                        size: 9,
                                        color: AppColors.blackColor,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
