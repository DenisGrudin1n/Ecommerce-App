import 'package:ecommerce_app/core/constants/texts/get_started_page_texts.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowColor,
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: MediaQuery.of(context).size.width - 320,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: GetStartedPageTexts.getStartedText,
    );
  }
}
