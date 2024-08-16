import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedPageTextStyles {
  static TextStyle myTextStyle = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.yellowColor,
  );

  static Text shopText = Text(
    'Shop',
    style: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.whiteColor,
    ),
  );

  static TextStyle shopTextStyle = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static TextStyle loremIpsumTextStyle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
    height: 19 / 14,
    letterSpacing: -0.15,
    // textAlign: TextAlign.center,
  );

  static TextStyle getStartedTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.whiteColor,
    height: 22 / 17,
    letterSpacing: 0,
  );
}
