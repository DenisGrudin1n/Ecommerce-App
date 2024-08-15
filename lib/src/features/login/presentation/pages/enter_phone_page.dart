import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/constants/texts/enter_phone_page_texts.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/enter_phone_page/phone_input_field.dart';
import 'package:ecommerce_app/core/widgets/enter_phone_page/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/enter_phone_page/send_verification_code_button.dart';
import 'package:ecommerce_app/core/widgets/enter_phone_page/skip_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EnterPhonePage extends StatelessWidget {
  const EnterPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Purple figure
          const EnterPhonePagePurpleFigure(),

          // Main Content
          Positioned.fill(
            top: 100,
            child: Column(
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 60),
                  child: EnterPhonePageTexts.whatIsYourPhoneNumberText,
                ),

                const SizedBox(height: 70),

                // Instruction
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: EnterPhonePageTexts.enterPhoneText,
                ),

                const SizedBox(height: 20),

                // Phone Number Input Field
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: PhoneInputField(),
                ),

                const SizedBox(height: 25),

                // Send Verification Code Button
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SendVerificationCodeButton(),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Skip Button
                const SkipButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
