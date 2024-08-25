import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/verification_page_text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/login/bloc/verification_page/verification_code_input_bloc/verification_code_input_bloc.dart';
import 'package:ecommerce_app/src/features/login/data/repositories/auth_repository.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/widgets/verification_code_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerificationPage extends StatefulWidget {
  const VerificationPage({
    required this.phoneNumber,
    required this.phoneCode,
    required this.verificationId,
    super.key,
  });
  final String phoneNumber;
  final String phoneCode;
  final String verificationId;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late final AuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    authRepository = RepositoryProvider.of<AuthRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                          context
                              .localization.verificationPagePleaseEnterCodeText,
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
                            '+${widget.phoneCode}${widget.phoneNumber}',
                            style:
                                VerificationPageTextStyles.phoneNumberTextStyle,
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
                  onPressed: () async {
                    try {
                      final codeState =
                          BlocProvider.of<VerificationCodeBloc>(context).state
                              as VerificationCodeUpdated;
                      final smsCode = codeState.code;

                      final cred = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: smsCode,
                      );

                      await authRepository.signInWithCredential(cred);

                      if (context.mounted) {
                        await context.router.push(
                          const HomeRoute(),
                        );
                      }
                    } catch (e) {
                      log(e.toString());
                    }
                  },
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
    );
  }
}
