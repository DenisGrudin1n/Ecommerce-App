import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutSection extends StatefulWidget {
  const CheckoutSection({super.key});

  @override
  State<CheckoutSection> createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> {
  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = context.select<CheckoutBloc, String>(
      (bloc) => bloc.state.selectedPaymentMethod,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          _buildShippingInfo(),
          const SizedBox(
            height: 33,
          ),
          _buildDeliveryMethod(context, selectedPaymentMethod),
          const SizedBox(
            height: 33,
          ),
          _buildPaymentMethod(),
        ],
      ),
    );
  }

  Widget _buildShippingInfo() {
    return Column(
      children: [
        Row(
          children: [
            const GradientIcon(
              icon: Icons.location_on_outlined,
              gradient: AppGradients.purpleGradient,
              size: 28,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Shipping Address',
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 12, bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(0.08),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Oleh Chabanov',
                    style: ProductPageTextStyles.productPageUserNameTextStyle,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.router.push(const ShippingAddressEditingRoute());
                    },
                    child: const Row(
                      children: [
                        GradientText(
                          text: 'Change',
                          style: TextStyle(
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            height: 16 / 12,
                            letterSpacing: 0,
                          ),
                          gradient: AppGradients.purpleGradient,
                        ),
                        GradientIcon(
                          icon: Icons.arrow_forward_ios,
                          size: 16,
                          gradient: AppGradients.purpleGradient,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '225 Highland Ave',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.darkGreyColor,
                  height: 19 / 14,
                  letterSpacing: -0.15,
                ),
              ),
              Text(
                'Springfield, IL 62704, USA',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.darkGreyColor,
                  height: 19 / 14,
                  letterSpacing: -0.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryMethod(
    BuildContext context,
    String selectedPaymentMethod,
  ) {
    return Column(
      children: [
        Row(
          children: [
            const GradientIcon(
              icon: Icons.local_shipping_outlined,
              gradient: AppGradients.purpleGradient,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Delivery Method',
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPaymentOption(
              context,
              'DHL',
              r'$15',
              '1-2 days',
              selectedPaymentMethod,
            ),
            _buildPaymentOption(
              context,
              'FedEx',
              r'$18',
              '1-2 days',
              selectedPaymentMethod,
            ),
            _buildPaymentOption(
              context,
              'USPS',
              r'$20',
              '1-2 days',
              selectedPaymentMethod,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String paymentMethod,
    String price,
    String time,
    String selectedPaymentMethod,
  ) {
    final isSelected = selectedPaymentMethod == paymentMethod;

    return GestureDetector(
      onTap: () {
        context
            .read<CheckoutBloc>()
            .add(UpdatePaymentMethodEvent(paymentMethod));
      },
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 12, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? AppColors.yellowColor : AppColors.transparentColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                paymentMethod == 'DHL'
                    ? Assets.images.item1.path
                    : paymentMethod == 'FedEx'
                        ? Assets.images.item2.path
                        : Assets.images.item3.path,
              ),
              height: 16,
              width: 71,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: ProductPageTextStyles.productPageUserNameTextStyle,
            ),
            Text(
              time,
              style: ProductPageTextStyles.productPageHelpfulTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      children: [
        Row(
          children: [
            const GradientIcon(
              icon: Icons.credit_card_outlined,
              gradient: AppGradients.purpleGradient,
              size: 28,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Payment Method',
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(0.08),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(Assets.images.mastercard.path),
                height: 27,
                width: 36,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                '**** **** **** 5678',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.darkColor,
                  height: 19 / 14,
                  letterSpacing: 0.85,
                ),
              ),
              const Spacer(),
              const GradientText(
                text: 'Change',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 16 / 12,
                  letterSpacing: 0,
                ),
                gradient: AppGradients.purpleGradient,
              ),
              const GradientIcon(
                icon: Icons.arrow_forward_ios,
                size: 16,
                gradient: AppGradients.purpleGradient,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
