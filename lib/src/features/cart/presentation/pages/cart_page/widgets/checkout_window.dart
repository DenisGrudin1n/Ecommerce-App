import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutWindow extends StatelessWidget {
  const CheckoutWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select((CartBloc bloc) => bloc.state.products);

    final totalPrice = products.fold<double>(
      0,
      (sum, product) => sum + product.productPrice * product.counter,
    );

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
                '\$${totalPrice.toStringAsFixed(2)}',
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
                onPressed: products.isNotEmpty
                    ? () {
                        context.router.push(const CheckoutRoute());
                      }
                    : null,
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
