import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/core/widgets/snackbars.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page/bloc/enter_phone_bloc.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page/widgets/enter_phone_field.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EnterPhonePage extends StatelessWidget {
  const EnterPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnterPhoneBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
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
                        context.localization
                            .enterPhonePageWhatIsYourPhoneNumberText,
                        style: EnterPhonePageTextStyles
                            .whatIsYourPhoneNumberTextStyle,
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
                      child: EnterPhoneField(),
                    ),

                    const SizedBox(height: 25),

                    // Send Verification Code Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SendVerificationCodeButton(
                        onPressed: () {
                          final currentState = context
                              .read<EnterPhoneBloc>()
                              .state as EnterPhoneUpdated;
                          final phoneNumber = currentState.phoneNumber;
                          final phoneCode = currentState.country.phoneCode;

                          // Check if phone number is valid
                          if (phoneNumber.length < 8) {
                            ErrorSnackBar.show(
                              context: context,
                              message: context.localization
                                  .errorIncorrectPhoneNumberFormatText,
                            );
                            return;
                          }

                          BlocProvider.of<EnterPhoneBloc>(context).add(
                            VerifyPhoneNumber(
                              verificationCompleted: () {},
                              verificationFailed: (exception) {
                                ErrorSnackBar.show(
                                  context: context,
                                  message: exception,
                                );
                                log(exception);
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
                                ErrorSnackBar.show(
                                  context: context,
                                  message: context.localization
                                      .errorAutoRetrievalTimeoutText,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // Skip Button
                    TextButton(
                      onPressed: () {
                        context.router.push(
                          const HomeRoute(),
                        );
                      },
                      child: Text(
                        context.localization.enterPhonePageSkipText,
                        style: EnterPhonePageTextStyles.skipTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
