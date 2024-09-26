import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        ProfileOption(
          icon: Icons.location_on_outlined,
          text: context.localization.profilePageShippingAddressesText,
        ),
        ProfileOption(
          icon: Icons.credit_card_outlined,
          text: context.localization.profilePagePaymentMethodsText,
        ),
        ProfileOption(
          icon: Icons.shopping_bag_outlined,
          text: context.localization.profilePageOrdersText,
        ),
        ProfileOption(
          icon: Icons.favorite_outline,
          text: context.localization.profilePageFavoriteText,
        ),
        ProfileOption(
          icon: Icons.settings_outlined,
          text: context.localization.profilePageSettingsText,
        ),
        ProfileOption(
          icon: Icons.logout_outlined,
          text: context.localization.profilePageLogoutText,
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    required this.icon,
    required this.text,
    super.key,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 55,
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
            const SizedBox(width: 16),
            GradientIcon(
              icon: icon,
              gradient: AppGradients.purpleGradient,
              size: 26,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: ProfilePageTextStyles.profileOptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
