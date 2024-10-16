import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/bloc/profile_bloc.dart';

import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/widgets/profile_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/widgets/profile_options.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              children: const [
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
      ),
    );
  }
}
