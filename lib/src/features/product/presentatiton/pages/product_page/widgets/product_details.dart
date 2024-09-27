import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localization.productPageDetailsText,
            style: ProductPageTextStyles.productDetailsStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            context.localization.productPageProductDetailsText,
            style: ProductPageTextStyles.productDetailsTextStyle,
          ),
          const Center(
            child: AppIcons.productDetailOpenFullIcon,
          ),
        ],
      ),
    );
  }
}
