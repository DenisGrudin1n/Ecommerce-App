import 'package:ecommerce_app/core/constants/texts/enter_phone_page_texts.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SendVerificationCodeButton extends StatelessWidget {
  const SendVerificationCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowColor,
        minimumSize: const Size.fromHeight(65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: EnterPhonePageTexts.sendVerificationCodeText,
    );
  }
}
