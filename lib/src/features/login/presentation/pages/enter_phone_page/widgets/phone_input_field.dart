import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles/enter_phone_page_text_styles.dart';
import 'package:ecommerce_app/src/features/login/bloc/enter_phone_page/phone_input_bloc/phone_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({super.key});

  void showPicker(BuildContext context) {
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
        BlocProvider.of<PhoneInputBloc>(context).add(CountryChanged(country));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneInputBloc, PhoneInputState>(
      builder: (context, state) {
        final country = state is PhoneInputUpdated
            ? state.country
            : CountryParser.parseCountryCode('UA');
        final phoneNumber = state is PhoneInputUpdated ? state.phoneNumber : '';
        final border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.transparentColor,
          ),
        );

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
                  initialValue: phoneNumber,
                  style: EnterPhonePageTextStyles.enterPhoneNumsTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText:
                        context.localization.enterPhonePageHintPhoneNumsText,
                    hintStyle: EnterPhonePageTextStyles.hintPhoneNumsTextStyle,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: GestureDetector(
                      onTap: () => showPicker(context),
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
                              style: EnterPhonePageTextStyles
                                  .enterPhoneNumsTextStyle,
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
                  onChanged: (value) {
                    BlocProvider.of<PhoneInputBloc>(context)
                        .add(PhoneNumberChanged(value));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
