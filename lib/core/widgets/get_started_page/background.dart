import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/opacities.dart';
import 'package:flutter/material.dart';

class GetStartedPageBackground extends StatelessWidget {
  const GetStartedPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.backgroundColor.withOpacity(AppOpacities.lightOpacity),
    );
  }
}
