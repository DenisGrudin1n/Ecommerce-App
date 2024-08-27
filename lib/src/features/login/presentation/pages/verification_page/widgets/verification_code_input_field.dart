import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/text_styles.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/bloc/verification_code_input_bloc/verification_code_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeInputField extends StatelessWidget {
  const VerificationCodeInputField({super.key});

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
      onChanged: (value) {
        BlocProvider.of<VerificationCodeBloc>(context).add(CodeChanged(value));
      },
      textStyle: VerificationPageTextStyles.enterVerificationCodeTextStyle,
    );
  }
}
