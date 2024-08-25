import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

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
