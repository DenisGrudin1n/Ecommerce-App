import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppShadows {
  static BoxShadow defaultContainerBoxShadow = BoxShadow(
    color: AppColors.darkColor.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 12,
  );

  static BoxShadow favoriteIconBoxShadow = BoxShadow(
    color: AppColors.blackColor.withOpacity(0.1),
    blurRadius: 6,
  );
}
