import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            'Product details',
            style: GoogleFonts.inter(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.darkColor,
              height: 23 / 19,
              letterSpacing: -0.49,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Women's Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor,
              height: 19 / 14,
              letterSpacing: -0.15,
            ),
          ),
          const Center(
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
