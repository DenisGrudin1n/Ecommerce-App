import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:flutter/material.dart';

class EnterPhonePagePurpleFigure extends StatelessWidget {
  const EnterPhonePagePurpleFigure({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          gradient: AppGradients.purpleGradient,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
