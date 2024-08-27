import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localization.homePageMyText,
                  style: HomePageTextStyles.homeMyTextStyle,
                ),
                Text(
                  context.localization.homePageShopText,
                  style: HomePageTextStyles.homeShopTextStyle,
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
