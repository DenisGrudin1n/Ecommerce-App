import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            gradient: AppGradients.purpleGradient,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(300),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(Assets.images.profilePic.path),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localization.profilePageUserNameText,
                    style: ProfilePageTextStyles.userNameTextstyle,
                  ),
                  Text(
                    context.localization.profilePageUserPhoneNumberText,
                    style: ProfilePageTextStyles.userPhoneNumberTextstyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24,
          right: 16,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: AppIcons.profilePageEditIcon,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
