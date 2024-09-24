import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/product/models/color_pic_model.dart';
import 'package:ecommerce_app/src/features/product/models/product_model.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductAppbar extends StatefulWidget {
  const ProductAppbar({super.key});

  @override
  State<ProductAppbar> createState() => _ProductAppbarState();
}

class _ProductAppbarState extends State<ProductAppbar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ProductBloc>().add(LoadAppbarProductsEvent());
    context.read<ProductBloc>().add(LoadAppbarSizesEvent());
    context.read<ProductBloc>().add(LoadAppbarColorsPicsEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appbarProducts =
        context.select<ProductBloc, List<AppbarProductModel>>(
      (bloc) => bloc.state.appbarProducts,
    );

    final isLoadingAppbarProduct = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isLoadingAppbarProducts,
    );
    final errorMessage = context.select<ProductBloc, String>(
      (bloc) => bloc.state.appbarProductsErrorMessage,
    );

    final sizes = context.select<ProductBloc, List<SizeModel>>(
      (bloc) => bloc.state.appbarProductsSizes,
    );
    final selectedSize = context.select<ProductBloc, List<String>>(
      (bloc) => bloc.state.selectedAppbarProductsSizes,
    );
    final isLoadingSizes = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isLoadingAppbarProductsSizes,
    );
    final sizesErrorMessage = context.select<ProductBloc, String>(
      (bloc) => bloc.state.appbarProductsSizesErrorMessage,
    );

    final colorsPics = context.select<ProductBloc, List<AppbarColorPicModel>>(
      (bloc) => bloc.state.appbarProductsColorsPics,
    );
    final selectedColorPic = context.select<ProductBloc, List<String>>(
      (bloc) => bloc.state.selectedAppbarProductsColorPics,
    );
    final isLoadingColorsPics = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isLoadingAppbarColorsPics,
    );
    final colorsPicsErrorMessage = context.select<ProductBloc, String>(
      (bloc) => bloc.state.appbarProductsColorsPicsErrorMessage,
    );

    if (appbarProducts.isEmpty) {
      return Center(
        child: Text(context.localization.noItemsFoundText),
      );
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          if (isLoadingAppbarProduct)
            const Center(child: CircularProgressIndicator())
          else
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              appbarProducts[0].imageUrls[index],
                            ),
                            fit: BoxFit.contain,
                          ),
                          color: AppColors.whiteColor,
                        ),
                        child: appbarProducts[0].imageUrls[0].isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : null,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: WormEffect(
                        activeDotColor: AppColors.whiteColor,
                        dotColor: AppColors.lightGreyColor.withOpacity(0.5),
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (starIndex) => AppIcons.productPageStarIcon,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                context.localization.productPageReviewsCountText,
                style: ProductPageTextStyles.reviewsCountTextStyle,
              ),
              const Spacer(),
              Text(
                context.localization.productPageInStockText,
                style: ProductPageTextStyles.inStockTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Product Name
          Text(
            appbarProducts[0].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ProductPageTextStyles.productNameTextStyle,
          ),
          const SizedBox(height: 14),
          // Price Section
          if (appbarProducts[0].oldPrice != null &&
              appbarProducts[0].oldPrice!.isNotEmpty)
            Row(
              children: [
                Text(
                  '\$${appbarProducts[0].price}',
                  style: ProductPageTextStyles.productRedPriceTextStyle,
                ),
                const SizedBox(width: 5),
                Text(
                  '\$${appbarProducts[0].oldPrice}',
                  style: ProductPageTextStyles.productGreyPriceTextStyle,
                ),
              ],
            )
          else
            Text(
              '\$${appbarProducts[0].price}',
              style: ProductPageTextStyles.productDarkPriceTextStyle,
            ),

          const SizedBox(height: 16),

          if (isLoadingColorsPics)
            const Center(child: CircularProgressIndicator())
          else if (colorsPicsErrorMessage.isNotEmpty)
            Text(errorMessage)
          else
            Text(
              context.localization.filterPageColorsText,
              style: FilterPageTextStyles.sectionNameTextStyle,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: colorsPics.map((colorPic) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<ProductBloc>()
                      .add(ChangeAppbarColorPicEvent(colorPic.imageUrl));
                },
                child: _buildColorsPicsItem(colorPic, selectedColorPic),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          if (isLoadingSizes)
            const Center(child: CircularProgressIndicator())
          else if (sizesErrorMessage.isNotEmpty)
            Text(errorMessage)
          else
            Text(
              context.localization.filterPageSizesText,
              style: FilterPageTextStyles.sectionNameTextStyle,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: sizes.map((size) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<ProductBloc>()
                      .add(ChangeAppbarSizeEvent(size.name));
                },
                child: _buildSizeButton(size, selectedSize),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButton(SizeModel size, List<String> selectedSizes) {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
      decoration: BoxDecoration(
        color: selectedSizes.contains(size.name)
            ? AppColors.yellowColor
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGreyColor,
        ),
      ),
      child: Center(
        child: Text(
          size.name,
          style: selectedSizes.contains(size.name)
              ? FilterPageTextStyles.selectedValueTextStyle
              : FilterPageTextStyles.valueTextStyle,
        ),
      ),
    );
  }

  Widget _buildColorsPicsItem(
    AppbarColorPicModel color,
    List<String> selectedColorPic,
  ) {
    return Container(
      height: 47,
      width: 47,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: selectedColorPic.contains(color.imageUrl)
            ? Border.all(
                color: AppColors.yellowColor,
                width: 2,
              )
            : Border.all(color: AppColors.transparentColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          color.imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
