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

class GradientText extends StatelessWidget {
  const GradientText({
    required this.text,
    required this.style,
    required this.gradient,
    super.key,
  });
  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    required this.icon,
    required this.size,
    required this.gradient,
    super.key,
  });
  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
