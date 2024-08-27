import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedPageTextStyles {
  static TextStyle myTextStyle = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.yellowColor,
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

class EnterPhonePageTextStyles {
  static TextStyle whatIsYourPhoneNumberTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    color: AppColors.whiteColor,
    height: 31 / 25,
    letterSpacing: 0.35,
  );

  static TextStyle enterPhoneTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 17,
    color: AppColors.darkGreyColor,
    height: 22 / 17,
    letterSpacing: -0.41,
  );

  static TextStyle ukrainianIdentifierNumsTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 19,
    color: AppColors.darkGreyColor,
    height: 23 / 19,
    letterSpacing: -0.49,
  );

  static TextStyle hintPhoneNumsTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 19,
    color: AppColors.lightGreyColor,
    height: 23 / 19,
    letterSpacing: -0.49,
  );
  static TextStyle enterPhoneNumsTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 19,
    color: AppColors.darkGreyColor,
    height: 23 / 19,
    letterSpacing: -0.49,
  );

  static TextStyle sendVerificationCodeTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 17,
    color: AppColors.whiteColor,
    height: 22 / 17,
    letterSpacing: 0,
  );

  static TextStyle skipTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 17,
    color: AppColors.greyColor,
    height: 22 / 17,
    letterSpacing: 0,
  );
}

class VerificationPageTextStyles {
  static TextStyle verificationCodeTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    color: AppColors.whiteColor,
    height: 31 / 25,
    letterSpacing: 0.35,
  );

  static TextStyle pleaseEnterCodeTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 17,
    color: AppColors.darkGreyColor,
    height: 22 / 17,
    letterSpacing: -0.41,
  );

  static TextStyle phoneNumberTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: AppColors.darkGreyColor,
    height: 22 / 17,
    letterSpacing: -0.41,
  );

  static TextStyle changePhoneNumberTextStyle = const TextStyle(
    fontFamily: 'SFProText',
    fontSize: 12,
    color: AppColors.darkColor,
    height: 16 / 12,
    letterSpacing: 0,
    decoration: TextDecoration.underline,
  );

  static TextStyle enterVerificationCodeTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    color: AppColors.darkGreyColor,
    height: 31 / 25,
    letterSpacing: 0.35,
  );

  static TextStyle sendVerificationCodeTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 17,
    color: AppColors.whiteColor,
    height: 22 / 17,
    letterSpacing: 0,
  );

  static TextStyle resendCodeTextStyle = const TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 17,
    color: AppColors.greyColor,
    height: 22 / 17,
    letterSpacing: 0,
  );
}

class HomePageTextStyles {
  static TextStyle homeMyTextStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.yellowColor,
  );

  static TextStyle homeShopTextStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
}
