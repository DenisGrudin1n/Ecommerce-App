import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/verification_page_text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/widgets/verification_code_input_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            // Purple figure
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PurpleFigure(),
            ),

            // Main Content
            ListView(
              padding: const EdgeInsets.only(top: 100),
              children: [
                // Title
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: Text(
                    context.localization.verificationPageVerificationCodeText,
                    style: VerificationPageTextStyles.verificationCodeTextStyle,
                  ),
                ),

                const SizedBox(height: 70),

                // Instruction
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            context.localization
                                .verificationPagePleaseEnterCodeText,
                            style: VerificationPageTextStyles
                                .pleaseEnterCodeTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '+380991234567',
                              style: VerificationPageTextStyles
                                  .phoneNumberTextStyle,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              context.localization
                                  .verificationPageChangePhoneNumberText,
                              style: VerificationPageTextStyles
                                  .changePhoneNumberTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Verification Code Input Field
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: VerificationCodeInputField(),
                ),

                const SizedBox(height: 25),

                // Send Verification Code Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SendVerificationCodeButton(
                    onPressed: () {},
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Resend Code Button
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.localization.verificationPageResendCodeText,
                    style: VerificationPageTextStyles.resendCodeTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
