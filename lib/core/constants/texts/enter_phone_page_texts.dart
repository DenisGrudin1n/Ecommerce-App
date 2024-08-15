import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class EnterPhonePageTexts {
  static Text whatIsYourPhoneNumberText = const Text(
    'What Is Your Phone Number?',
    style: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 25,
      color: AppColors.whiteColor,
      height: 31 / 25,
      letterSpacing: 0.35,
    ),
    textAlign: TextAlign.start,
  );

  static Text enterPhoneText = const Text(
    'Please enter your phone number to verify your account',
    style: TextStyle(
      fontFamily: 'SFProText',
      fontSize: 17,
      color: AppColors.darkGreyColor,
      height: 22 / 17,
      letterSpacing: -0.41,
    ),
    textAlign: TextAlign.start,
  );

  static Text ukrainianIdentifierNums = const Text(
    '+380 ',
    style: TextStyle(
      fontFamily: 'SFProText',
      fontSize: 19,
      color: AppColors.darkGreyColor,
      height: 23 / 19,
      letterSpacing: -0.49,
    ),
  );

  static const String hintPhoneNums = '(99) 999 99 99';
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

  static Text sendVerificationCodeText = const Text(
    'Send Verification Code',
    style: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 17,
      color: AppColors.whiteColor,
      height: 22 / 17,
      letterSpacing: 0,
    ),
    textAlign: TextAlign.start,
  );

  static Text skipText = const Text(
    'Skip',
    style: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 17,
      color: AppColors.greyColor,
      height: 22 / 17,
      letterSpacing: 0,
    ),
    textAlign: TextAlign.start,
  );
}
