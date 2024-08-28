import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FashionSaleSection extends StatelessWidget {
  const FashionSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 95,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(Assets.images.fashionSectionBg.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.fashionSaleSectionGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Text(
                  context.localization.homePageFashionSaleText,
                  style: HomePageTextStyles.homeFashionSaleTextStyle,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      context.localization.homePageSeeMoreText,
                      style: HomePageTextStyles.homeSeeMoreTextStyle,
                    ),
                    AppIcons.seeMoreIcon,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
