import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:flutter/material.dart';

class PurpleFigure extends StatelessWidget {
  const PurpleFigure({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
        ),
      ),
    );
  }
}
