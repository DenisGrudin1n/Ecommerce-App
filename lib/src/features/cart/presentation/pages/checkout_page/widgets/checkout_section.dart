import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
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
          const SizedBox(
            height: 33,
          ),
          Row(
            children: [
              const GradientIcon(
                icon: Icons.local_shipping_outlined,
                gradient: AppGradients.purpleGradient,
                size: 28,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                'Delivery Method',
                style: ProductPageTextStyles.productDetailsStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
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
                  children: [
                    Image(
                      image: AssetImage(Assets.images.item1.path),
                      height: 16,
                      width: 71,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      r'$15',
                      style: ProductPageTextStyles.productPageUserNameTextStyle,
                    ),
                    Text(
                      '1-2 days',
                      style: ProductPageTextStyles.productPageHelpfulTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
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
                  children: [
                    Image(
                      image: AssetImage(Assets.images.item2.path),
                      height: 17,
                      width: 61,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      r'$18',
                      style: ProductPageTextStyles.productPageUserNameTextStyle,
                    ),
                    Text(
                      '1-2 days',
                      style: ProductPageTextStyles.productPageHelpfulTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
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
                  children: [
                    Image(
                      image: AssetImage(Assets.images.item3.path),
                      height: 10,
                      width: 82,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      r'$20',
                      style: ProductPageTextStyles.productPageUserNameTextStyle,
                    ),
                    Text(
                      '1-2 days',
                      style: ProductPageTextStyles.productPageHelpfulTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 33,
          ),
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
      ),
    );
  }
}
