import 'dart:math' as math;

import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:flutter/material.dart';

class AppIcons {
  static const Icon selectCountryIcon = Icon(
    Icons.keyboard_arrow_down,
    size: 20,
  );
  static const Icon openHomeDrawerIcon = Icon(
    Icons.menu,
    color: AppColors.whiteColor,
  );

  static const Icon notificationsIcon = Icon(
    Icons.notifications_none_outlined,
    color: AppColors.whiteColor,
  );

  static const Icon searchIcon = Icon(
    Icons.search,
    color: AppColors.greyColor,
  );

  static const Icon seeMoreIcon = Icon(
    Icons.arrow_forward_ios,
    size: 16,
    color: AppColors.yellowColor,
  );

  static const Icon seeAllIcon = Icon(
    Icons.arrow_forward_ios,
    size: 16,
    color: AppColors.greyColor,
  );

  static const Icon shoppingCartIcon = Icon(
    Icons.shopping_cart_outlined,
    color: AppColors.whiteColor,
    size: 28,
  );

  static const Icon homeNotActiveIcon = Icon(
    Icons.home,
    size: 28,
    color: AppColors.greyColor,
  );

  static const Icon catalogueNotActiveIcon = Icon(
    Icons.grid_view_outlined,
    size: 28,
    color: AppColors.greyColor,
  );

  static const Icon favoriteNotActiveIcon = Icon(
    Icons.favorite_outline,
    size: 28,
    color: AppColors.greyColor,
  );

  static const Icon profileNotActiveIcon = Icon(
    Icons.person_outline,
    size: 28,
    color: AppColors.greyColor,
  );

  static const Widget homeActiveIcon = GradientIcon(
    icon: Icons.home,
    size: 28,
    gradient: AppGradients.purpleGradient,
  );

  static const Widget catalogueActiveIcon = GradientIcon(
    icon: Icons.grid_view_outlined,
    size: 28,
    gradient: AppGradients.purpleGradient,
  );

  static const Widget favoriteActiveIcon = GradientIcon(
    icon: Icons.favorite_outline,
    size: 28,
    gradient: AppGradients.purpleGradient,
  );

  static const Widget profileActiveIcon = GradientIcon(
    icon: Icons.person_outline,
    size: 28,
    gradient: AppGradients.purpleGradient,
  );

  static const Icon arrowBackIcon = Icon(
    Icons.arrow_back,
    color: AppColors.whiteColor,
  );

  static const Icon arrowBackTransparentIcon = Icon(
    Icons.arrow_back,
    color: AppColors.transparentColor,
  );

  static const Icon greyArrowBackIcon = Icon(
    Icons.arrow_back,
    color: AppColors.greyColor,
    size: 28,
  );

  static const Icon itemsSectionFeaturedIcon = Icon(
    Icons.keyboard_arrow_down,
    color: AppColors.darkColor,
  );

  static const Icon favoriteProductIcon = Icon(
    Icons.favorite,
    size: 28,
    color: AppColors.yellowColor,
  );

  static const Icon smallFavoriteProductIcon = Icon(
    Icons.favorite,
    size: 20,
    color: AppColors.yellowColor,
  );

  static const Icon productDetailOpenFullIcon = Icon(
    Icons.keyboard_arrow_down,
    size: 24,
    color: AppColors.greyColor,
  );

  static const Icon productPageThumbsUpIcon = Icon(
    Icons.thumb_up,
    size: 24,
    color: AppColors.blueColor,
  );

  static const Icon productPageThumbsUpOutlinedIcon = Icon(
    Icons.thumb_up_outlined,
    size: 24,
    color: AppColors.greyColor,
  );

  static const GradientIcon profilePageEditIcon = GradientIcon(
    icon: Icons.edit_outlined,
    gradient: AppGradients.purpleGradient,
    size: 26,
  );

  static const GradientIcon locationGradientIcon = GradientIcon(
    icon: Icons.location_on_outlined,
    gradient: AppGradients.purpleGradient,
    size: 28,
  );

  static const GradientIcon arrowForwardGradientIcon = GradientIcon(
    icon: Icons.arrow_forward_ios,
    size: 16,
    gradient: AppGradients.purpleGradient,
  );

  static const GradientIcon localShippingGradientIcon = GradientIcon(
    icon: Icons.local_shipping_outlined,
    gradient: AppGradients.purpleGradient,
    size: 28,
  );

  static const GradientIcon creditCardGradientIcon = GradientIcon(
    icon: Icons.credit_card_outlined,
    gradient: AppGradients.purpleGradient,
    size: 28,
  );

  static const Icon paymentSuccessIcon = Icon(
    Icons.check_circle_outline_rounded,
    color: AppColors.whiteColor,
    size: 64,
  );

  static const Icon checkIcon = Icon(
    Icons.check,
    color: AppColors.greyColor,
  );

  static const GradientIcon notFavoriteGradientIcon = GradientIcon(
    icon: Icons.favorite_border,
    size: 20,
    gradient: AppGradients.purpleGradient,
    strokeWidth: 1,
  );

  static const GradientIcon notFavoriteProductGradientIcon = GradientIcon(
    icon: Icons.favorite_border,
    size: 28,
    gradient: AppGradients.purpleGradient,
    strokeWidth: 1,
  );

  static Stack filterIcon = Stack(
    alignment: Alignment.center,
    children: [
      Transform.rotate(
        angle: 90 * math.pi / 180,
        child: const Icon(
          Icons.tune,
          color: AppColors.whiteColor,
        ),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.yellowColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  );

  static const Icon filterPageCategoriesOpenedIcon = Icon(
    Icons.keyboard_arrow_down,
    color: AppColors.greyColor,
    size: 28,
  );

  static const Icon filterPageCategoriesNotOpenedIcon = Icon(
    Icons.arrow_forward_ios,
    color: AppColors.greyColor,
    size: 18,
  );

  static const Icon starIcon = Icon(
    Icons.star,
    color: AppColors.orangeColor,
    size: 12,
  );

  static const Icon productPageStarIcon = Icon(
    Icons.star,
    color: AppColors.orangeColor,
    size: 16,
  );
}
