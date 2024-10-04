import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/widgets/profile_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/widgets/profile_options.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Stack(
        children: [
          const Column(
            children: [
              ProfileAppbar(),
              ProfileOptions(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 16,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                context.localization.profilePagePolicyText,
                style: ProfilePageTextStyles.policyTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
