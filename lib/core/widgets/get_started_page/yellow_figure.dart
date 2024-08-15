import 'dart:math' as math;

import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class YellowFigure extends StatelessWidget {
  const YellowFigure({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        width: 280,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.yellowColor.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(300),
          ),
        ),
      ),
    );
  }
}
