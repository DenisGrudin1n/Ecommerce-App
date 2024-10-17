import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessWindow extends StatelessWidget {
  const SuccessWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 345,
          width: MediaQuery.of(context).size.width - 48,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        Positioned(
          top: -233,
          child: Column(
            children: [
              Container(
                height: 345,
                width: MediaQuery.of(context).size.width - 48,
                decoration: const BoxDecoration(
                  gradient: AppGradients.purpleGradient,
                  shape: BoxShape.circle,
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: AppIcons.paymentSuccessIcon,
                  ),
                ),
              ),
              Center(
                child: Text(
                  context.localization.checkoutPageSuccessText,
                  style: ProductPageTextStyles.productDarkPriceTextStyle,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 96,
                child: Text(
                  context.localization.checkoutPageDeliveredSoonText,
                  style: ProductPageTextStyles.productDetailsTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 96,
                child: Text(
                  context.localization.checkoutPageOrdersTrackedText,
                  style: ProductPageTextStyles.productDetailsTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width - 112,
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const HomeRoute());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      context.localization.checkoutPageContinueShoppingText,
                      style: FilterPageTextStyles.resultsTextStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<CheckoutBloc>().add(HideSuccessWindowEvent());
                  },
                  child: Text(
                    context.localization.checkoutPageGoToOrdersText,
                    style: CheckoutPageTextStyles.goToOrdersTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
