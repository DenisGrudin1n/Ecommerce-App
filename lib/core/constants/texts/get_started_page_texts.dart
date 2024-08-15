import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedPageTexts {
  static Text myText = Text(
    'My',
    style: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: AppColors.yellowColor,
    ),
  );

  static Text shopText = Text(
    'Shop',
    style: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.whiteColor,
    ),
  );

  static Text loremIpsumText = Text(
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    style: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor,
      height: 19 / 14,
      letterSpacing: -0.15,
    ),
    textAlign: TextAlign.center,
  );

  static Text getStartedText = const Text(
    'Get Started',
    style: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteColor,
      height: 22 / 17,
      letterSpacing: 0,
    ),
  );
}
