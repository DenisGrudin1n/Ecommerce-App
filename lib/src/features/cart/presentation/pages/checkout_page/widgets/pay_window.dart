import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayWindow extends StatelessWidget {
  const PayWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select((CartBloc bloc) => bloc.state.products);

    final itemsPrice = products.fold<double>(
      0,
      (sum, product) => sum + product.productPrice * product.counter,
    );

    final deliveryMethod = context.select<CheckoutBloc, String>(
      (bloc) => bloc.state.selectedPaymentMethod,
    );

    double deliveryPrice;
    switch (deliveryMethod) {
      case 'DHL':
        deliveryPrice = 15;
      case 'FedEx':
        deliveryPrice = 18;
      case 'USPS':
        deliveryPrice = 20;
      default:
        deliveryPrice = 20;
    }

    final totalPrice = itemsPrice + deliveryPrice;

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
                context.localization.checkoutPageItemsText,
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
              const Spacer(),
              Text(
                '\$${itemsPrice.toStringAsFixed(2)}',
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
                context.localization.checkoutPageDeliveryText,
                style: FilterPageTextStyles.sectionNameTextStyle,
              ),
              const Spacer(),
              Text(
                '\$${deliveryPrice.toStringAsFixed(2)}',
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
                  context.localization.checkoutPagePayText,
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
