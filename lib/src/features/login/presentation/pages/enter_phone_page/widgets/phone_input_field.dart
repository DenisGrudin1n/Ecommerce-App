import 'package:ecommerce_app/core/constants/network_images_urls/enter_phone_page_images_urls.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/text_styles/enter_phone_page_text_styles.dart';
import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            EnterPhonePageImagesUrls.ukrainianFlagUrl,
            width: 32,
          ),
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_down),
          const SizedBox(width: 12),
          Text(
            context.localization.enterPhonePageUkrainianIdentifierNumsText,
            style: EnterPhonePageTextStyles.ukrainianIdentifierNumsTextStyle,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: EnterPhonePageTextStyles.enterPhoneNumsTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: context.localization.enterPhonePageHintPhoneNumsText,
                hintStyle: EnterPhonePageTextStyles.hintPhoneNumsTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
