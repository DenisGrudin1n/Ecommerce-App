import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayWindow extends StatelessWidget {
  const PayWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 18,
        bottom: 34,
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
                'Items',
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
              const Spacer(),
              Text(
                r'$239.98',
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Delivery',
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
              const Spacer(),
              Text(
                r'$18',
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                context.localization.cartPageTotalPriceText,
                style: ProductPageTextStyles.productDetailsStyle,
              ),
              const Spacer(),
              Text(
                r'$257.98',
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
                onPressed: () {
                  context.read<CheckoutBloc>().add(ShowLoadingEvent());
                  Future.delayed(const Duration(seconds: 2), () {
                    if (context.mounted) {
                      context
                          .read<CheckoutBloc>()
                          .add(ShowSuccessWindowEvent());
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Pay',
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
