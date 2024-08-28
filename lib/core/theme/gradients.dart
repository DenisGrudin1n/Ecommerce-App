import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [
      Color.fromRGBO(132, 95, 161, 1),
      Color.fromRGBO(52, 40, 62, 1),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static LinearGradient fashionSaleSectionGradient = LinearGradient(
    colors: [
      const Color(0x0034283e).withOpacity(1),
      const Color(0x001d2332).withOpacity(0.2),
    ],
  );
}
