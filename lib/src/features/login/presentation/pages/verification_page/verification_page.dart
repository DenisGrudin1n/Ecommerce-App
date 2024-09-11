import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/core/widgets/snackbars.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/bloc/verification_bloc.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/widgets/verification_code_input_field.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerificationPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationCodeVerified) {
            context.router.pushAndPopUntil(
              const HomeRoute(),
              predicate: (route) => false,
            );
          } else if (state is VerificationCodeFailed) {
            ErrorSnackBar.show(
              context: context,
              message: context.localization.errorIncorrectVerificationCodeText,
            );
          }
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
                      style:
                          VerificationPageTextStyles.verificationCodeTextStyle,
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
                                '+$phoneCode$phoneNumber',
                                style: VerificationPageTextStyles
                                    .phoneNumberTextStyle,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.router.push(const EnterPhoneRoute());
                              },
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    child: BlocBuilder<VerificationBloc, VerificationState>(
                      builder: (context, state) {
                        return VerificationCodeInputField(
                          verificationId: verificationId,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Send Verification Code Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: BlocBuilder<VerificationBloc, VerificationState>(
                      builder: (context, state) {
                        return SendVerificationCodeButton(
                          onPressed: () {
                            final bloc =
                                BlocProvider.of<VerificationBloc>(context);
                            if (state is VerificationCodeUpdated) {
                              bloc.add(
                                VerificationCodeChanged(
                                  verificationId,
                                  state.code,
                                ),
                              );
                            } else {
                              ErrorSnackBar.show(
                                context: context,
                                message: context.localization
                                    .errorNotEnteredVerificationCodeText,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Resend Code Button
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<VerificationBloc>(context).add(
                        ResendCodeRequested(
                          '+$phoneCode$phoneNumber',
                        ),
                      );
                    },
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
      ),
    );
  }
}
