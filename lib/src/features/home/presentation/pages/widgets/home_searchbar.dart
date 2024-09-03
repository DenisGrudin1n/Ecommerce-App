import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
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
            child: Row(
              children: [
                AppIcons.searchIcon,
                const SizedBox(width: 10),
                Text(
                  context.localization.homePageWhatAreYouLookingForText,
                  style: HomePageTextStyles.homeWhatAreYouLookingforTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
