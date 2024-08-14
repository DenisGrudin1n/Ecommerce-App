import 'package:ecommerce_app/core/constants/texts.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppTexts.getStartedPage,
          style: AppTextStyles.headlineLarge,
        ),
      ),
    );
  }
}
