import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/enter_phone_page_text_styles.dart';
import 'package:ecommerce_app/core/widgets/purple_figure.dart';
import 'package:ecommerce_app/core/widgets/send_verification_code_button.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page/widgets/phone_input_field.dart';
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
                  context.localization.enterPhonePageWhatIsYourPhoneNumberText,
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
                  onPressed: () {},
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
    );
  }
}
