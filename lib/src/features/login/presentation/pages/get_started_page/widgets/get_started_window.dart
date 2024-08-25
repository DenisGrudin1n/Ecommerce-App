import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles/get_started_page_text_styles.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page/widgets/get_started_button.dart';
import 'package:flutter/material.dart';

class GetStartedWindow extends StatelessWidget {
  const GetStartedWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.localization.getStartedPageMyText,
                style: GetStartedPageTextStyles.myTextStyle,
              ),
              Text(
                context.localization.getStartedPageShopText,
                style: GetStartedPageTextStyles.shopTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              context.localization.getStartedPageLoremIpsumText,
              style: GetStartedPageTextStyles.loremIpsumTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const GetStartedButton(),
        ],
      ),
    );
  }
}
