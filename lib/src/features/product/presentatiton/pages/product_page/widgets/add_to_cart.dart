import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/product/models/color_pic_model.dart';
import 'package:ecommerce_app/src/features/product/models/product_model.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final isCartExpanded = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isCartExpanded,
    );

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
    final selectedImageUrl = context.select<ProductBloc, String>(
      (bloc) => bloc.state.selectedImageUrl,
    );
    final isLoadingColorsPics = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isLoadingAppbarColorsPics,
    );
    final isProductFavorite = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isProductFavorite,
    );
    final colorsPicsErrorMessage = context.select<ProductBloc, String>(
      (bloc) => bloc.state.appbarProductsColorsPicsErrorMessage,
    );

    final counter = context.select<ProductBloc, int>(
      (bloc) => bloc.state.counter,
    );

    final productName = appbarProducts.isNotEmpty ? appbarProducts[0].name : '';
    final productPrice =
        appbarProducts.isNotEmpty ? double.parse(appbarProducts[0].price) : 0.0;
    final imageUrl = selectedImageUrl.isNotEmpty
        ? selectedImageUrl
        : appbarProducts.isNotEmpty
            ? appbarProducts[0].imageUrls[0]
            : '';

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 125),
          height: isCartExpanded ? 335 : 0,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
          ),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: !isCartExpanded
              ? const SizedBox.shrink()
              : ListView(
                  physics: const ScrollPhysics(
                    parent: NeverScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.zero,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(ToggleCartSizeEvent());
                      },
                      child: Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.lightGreyColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    if (isLoadingAppbarProduct)
                      const Center(child: CircularProgressIndicator())
                    else if (errorMessage.isNotEmpty)
                      Text(errorMessage)
                    else
                      _buildProductSection(
                        appbarProducts[0],
                        context,
                        counter,
                        selectedImageUrl,
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
                            context.read<ProductBloc>().add(
                                  ChangeColorPicEvent(
                                    colorPic.imageUrl,
                                    colorPic.imageUrl,
                                  ),
                                );
                          },
                          child:
                              _buildColorsPicsItem(colorPic, selectedColorPic),
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
        ),
        _buildBottomBarSection(
          context,
          isProductFavorite,
          isCartExpanded,
          productName,
          productPrice,
          counter,
          imageUrl,
        ),
      ],
    );
  }

  Widget _buildProductSection(
    AppbarProductModel product,
    BuildContext context,
    int counter,
    String selectedImageUrl,
  ) {
    final productPrice = double.parse(product.price);
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              selectedImageUrl.isNotEmpty
                  ? selectedImageUrl
                  : product.imageUrls[0],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: ProductPageTextStyles
                    .productPageAddToCartProductNameTextStyle,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '\$${(productPrice * counter).toStringAsFixed(2)}',
                style: HomePageTextStyles
                    .homePageFeaturedProductDarkPriceTextStyle,
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.read<ProductBloc>().add(IncrementCounterEvent());
              },
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.greyColor,
            ),
            Text(
              counter.toString(),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGreyColor,
                height: 19 / 14,
                letterSpacing: -0.15,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<ProductBloc>().add(DecrementCounterEvent());
              },
              icon: const Icon(Icons.remove_circle_outline),
              color: AppColors.greyColor,
            ),
          ],
        ),
      ],
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

  Widget _buildBottomBarSection(
    BuildContext context,
    bool isProductFavorite,
    bool isCartExpanded,
    String productName,
    double productPrice,
    int counter,
    String imageUrl,
  ) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.router.back();
            },
            icon: AppIcons.greyArrowBackIcon,
          ),
          SizedBox(
            width: 215,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (isCartExpanded) {
                  context.read<CartBloc>().add(LoadCartProductsEvent());
                  context.read<CartBloc>().add(
                        UpdateCartEvent(
                          productName,
                          productPrice,
                          counter,
                          imageUrl,
                        ),
                      );
                  context.pushRoute(const CartRoute());
                } else {
                  context.read<ProductBloc>().add(ToggleCartSizeEvent());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                context.localization.productPageAddToCartText,
                style: FilterPageTextStyles.resultsTextStyle,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ProductBloc>().add(ToggleProductFavoriteEvent());
            },
            icon: isProductFavorite
                ? AppIcons.favoriteProductIcon
                : AppIcons.notFavoriteProductGradientIcon,
          ),
        ],
      ),
    );
  }
}
