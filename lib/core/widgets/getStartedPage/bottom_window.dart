import 'package:ecommerce_app/core/constants/texts/get_started_page_texts.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/widgets/getStartedPage/get_started_button.dart';
import 'package:flutter/material.dart';

class GetStartedPageBottomWindow extends StatelessWidget {
  const GetStartedPageBottomWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 270,
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
                GetStartedPageTexts.myText,
                GetStartedPageTexts.shopText,
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: GetStartedPageTexts.loremIpsumText,
            ),
            const SizedBox(
              height: 32,
            ),
            const GetStartedButton(),
          ],
        ),
      ),
    );
  }
}
