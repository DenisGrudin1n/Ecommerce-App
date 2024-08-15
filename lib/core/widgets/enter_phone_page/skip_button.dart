import 'package:ecommerce_app/core/constants/texts/enter_phone_page_texts.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: EnterPhonePageTexts.skipText,
    );
  }
}
