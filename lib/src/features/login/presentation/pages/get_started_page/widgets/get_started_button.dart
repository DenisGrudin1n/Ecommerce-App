import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/get_started_page_text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.router.push(const EnterPhoneRoute());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowColor,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 75,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        context.localization.getStartedPageGetStartedText,
        style: GetStartedPageTextStyles.getStartedTextStyle,
      ),
    );
  }
}
