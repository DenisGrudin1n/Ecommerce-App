import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/enter_phone_page_text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/login/bloc/enter_phone_page/phone_input_bloc/phone_input_bloc.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page/widgets/phone_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EnterPhonePage extends StatelessWidget {
  const EnterPhonePage({super.key});

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
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 60,
                  ),
                  child: Text(
                    context
                        .localization.enterPhonePageWhatIsYourPhoneNumberText,
                    style:
                        EnterPhonePageTextStyles.whatIsYourPhoneNumberTextStyle,
                  ),
                ),

                const SizedBox(height: 70),

                // Instruction
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    context.localization.enterPhonePageEnterPhoneText,
                    style: EnterPhonePageTextStyles.enterPhoneTextStyle,
                  ),
                ),

                const SizedBox(height: 20),

                // Phone Number Input Field
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: PhoneInputField(),
                ),

                const SizedBox(height: 25),

                // Send Verification Code Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SendVerificationCodeButton(
                    onPressed: () {
                      final phoneState =
                          BlocProvider.of<PhoneInputBloc>(context).state
                              as PhoneInputUpdated;
                      final phoneNumber = phoneState.phoneNumber;
                      final phoneCode = phoneState.country.phoneCode;
                      final fullPhoneNumber = '+$phoneCode$phoneNumber';

                      FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: fullPhoneNumber,
                        verificationCompleted: (phoneAuthCredential) {},
                        verificationFailed: (error) {
                          log(error.toString());
                        },
                        codeSent: (verificationId, forceResendingToken) {
                          context.router.push(
                            VerificationRoute(
                              phoneNumber: phoneNumber,
                              phoneCode: phoneCode,
                              verificationId: verificationId,
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (verificationId) {
                          log('Auto Retrieval Timeout');
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Skip Button
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.localization.enterPhonePageSkipText,
                    style: EnterPhonePageTextStyles.skipTextStyle,
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
