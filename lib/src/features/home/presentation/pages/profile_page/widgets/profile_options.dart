import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/shadows.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onTap: () => context.router.push(const CheckoutRoute()),
        ),
        ProfileOption(
          icon: Icons.credit_card_outlined,
          text: context.localization.profilePagePaymentMethodsText,
          onTap: () => context.router.push(const CheckoutRoute()),
        ),
        ProfileOption(
          icon: Icons.shopping_bag_outlined,
          text: context.localization.profilePageOrdersText,
          onTap: () => context.router.push(const CartRoute()),
        ),
        ProfileOption(
          icon: Icons.favorite_outline,
          text: context.localization.profilePageFavoriteText,
          onTap: () => context.router.push(const FavoriteRoute()),
        ),
        ProfileOption(
          icon: Icons.settings_outlined,
          text: context.localization.profilePageSettingsText,
        ),
        ProfileOption(
          icon: Icons.logout_outlined,
          text: context.localization.profilePageLogoutText,
          onTap: () {
            context.read<ProfileBloc>().add(
              LogoutRequested(
                onSuccess: () {
                  context.router.replace(
                    const GetStartedRoute(),
                  );
                },
              ),
            );
          },
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
    this.onTap,
    super.key,
  });
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              AppShadows.defaultContainerBoxShadow,
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
      ),
    );
  }
}
