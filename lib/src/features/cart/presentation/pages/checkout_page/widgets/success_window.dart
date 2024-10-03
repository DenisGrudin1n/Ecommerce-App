import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
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
          top: -248,
          child: Column(
            children: [
              Container(
                height: 360,
                width: MediaQuery.of(context).size.width - 48,
                decoration: const BoxDecoration(
                  gradient: AppGradients.purpleGradient,
                  shape: BoxShape.circle,
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.whiteColor,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Success',
                  style: ProductPageTextStyles.productDarkPriceTextStyle,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 96,
                child: Text(
                  'Your order will be delivered soon.',
                  style: ProductPageTextStyles.productDetailsTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 96,
                child: Text(
                  'It can be tracked in the "Orders" section.',
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
                      context
                          .read<CheckoutBloc>()
                          .add(HideSuccessWindowEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue Shopping',
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
                  child: const Text(
                    'Go to Orders',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.greyColor,
                      height: 22 / 17,
                      letterSpacing: 0,
                    ),
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
