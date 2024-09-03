import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class SendVerificationCodeButton extends StatelessWidget {
  const SendVerificationCodeButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowColor,
        minimumSize: const Size.fromHeight(65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        context.localization.enterPhonePageSendVerificationCodeText,
        style: EnterPhonePageTextStyles.sendVerificationCodeTextStyle,
      ),
    );
  }
}
