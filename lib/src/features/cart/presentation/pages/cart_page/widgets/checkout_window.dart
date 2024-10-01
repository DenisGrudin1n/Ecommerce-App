import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CheckoutWindow extends StatelessWidget {
  const CheckoutWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                context.localization.cartPageTotalPriceText,
                style: ProductPageTextStyles.productDetailsStyle,
              ),
              const Spacer(),
              Text(
                r'$239.98',
                style: ProductPageTextStyles.productDetailsStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  context.localization.cartPageCheckOutText,
                  style: FilterPageTextStyles.resultsTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
