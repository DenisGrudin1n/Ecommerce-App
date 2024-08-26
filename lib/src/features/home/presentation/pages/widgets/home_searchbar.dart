import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 88,
          ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.greyColor),
                SizedBox(width: 10),
                Text(
                  'What are you looking for?',
                  style: TextStyle(color: AppColors.greyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
