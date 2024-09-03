import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildFeaturedItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 10,
            color: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}
