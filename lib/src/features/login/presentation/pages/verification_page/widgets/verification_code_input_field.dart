import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/bloc/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeInputField extends StatelessWidget {
  const VerificationCodeInputField({
    required this.verificationId,
    super.key,
  });

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      keyboardType: TextInputType.number,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: AppColors.whiteColor,
        selectedColor: AppColors.redColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      onChanged: (code) {
        BlocProvider.of<VerificationBloc>(context).add(
          VerificationCodeChanged(
            verificationId,
            code,
          ),
        );
      },
      textStyle: VerificationPageTextStyles.enterVerificationCodeTextStyle,
    );
  }
}
