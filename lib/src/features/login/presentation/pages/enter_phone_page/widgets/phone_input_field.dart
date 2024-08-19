import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/enter_phone_page_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({super.key});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  Country country = CountryParser.parseCountryCode('UA');

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: AppColors.transparentColor,
    ),
  );

  void showPicker() {
    showCountryPicker(
      context: context,
      favorite: [
        'UA',
        'US',
      ],
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        borderRadius: BorderRadius.circular(20),
        backgroundColor: AppColors.whiteColor,
        inputDecoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: context.localization.enterPhonePageSearchCountryText,
        ),
      ),
      onSelect: (country) {
        setState(() {
          this.country = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: EnterPhonePageTextStyles.enterPhoneNumsTextStyle,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: context.localization.enterPhonePageHintPhoneNumsText,
                hintStyle: EnterPhonePageTextStyles.hintPhoneNumsTextStyle,
                enabledBorder: border,
                focusedBorder: border,
                prefixIcon: GestureDetector(
                  onTap: showPicker,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          country.flagEmoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '+ ${country.phoneCode}',
                          style:
                              EnterPhonePageTextStyles.enterPhoneNumsTextStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
