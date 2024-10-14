import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/bloc/shipping_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingTextFields extends StatefulWidget {
  const ShippingTextFields({super.key});

  @override
  State<ShippingTextFields> createState() => _ShippingTextFieldsState();
}

class _ShippingTextFieldsState extends State<ShippingTextFields> {
  @override
  Widget build(BuildContext context) {
    final fullName = context.select<ShippingBloc, String>(
      (bloc) => bloc.state.fullName,
    );
    final address = context.select<ShippingBloc, String>(
      (bloc) => bloc.state.address,
    );
    final city = context.select<ShippingBloc, String>(
      (bloc) => bloc.state.city,
    );
    final postalCode = context.select<ShippingBloc, String>(
      (bloc) => bloc.state.postalCode,
    );
    final phone = context.select<ShippingBloc, String>(
      (bloc) => bloc.state.phone,
    );

    return BlocListener<ShippingBloc, ShippingState>(
      listener: (context, state) {
        if (state.navigateToCheckout) {
          context.router.push(const CheckoutRoute());
          context.read<ShippingBloc>().add(ResetNavigationEvent());
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              context,
              context.localization.shippingPageFullNameErrorText,
              fullName,
              (value) {
                _updateShippingInfo(context, fullName: value);
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              context.localization.shippingPageAddressErrorText,
              address,
              (value) {
                _updateShippingInfo(context, address: value);
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              context.localization.shippingPageCityErrorText,
              city,
              (value) {
                _updateShippingInfo(context, city: value);
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              context.localization.shippingPagePostalCodeErrorText,
              postalCode,
              (value) {
                _updateShippingInfo(context, postalCode: value);
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              context.localization.shippingPagePhoneNumberErrorText,
              phone,
              (value) {
                _updateShippingInfo(context, phone: value);
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<ShippingBloc>()
                        .add(ValidateShippingInfoEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    context.localization.shippingPageSaveText,
                    style: FilterPageTextStyles.resultsTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String emptyTextField,
    String initialValue,
    void Function(String) onChanged,
  ) {
    final showError =
        context.select((ShippingBloc bloc) => bloc.state.showError);

    return Column(
      children: [
        TextFormField(
          initialValue: initialValue,
          cursorColor: AppColors.darkGreyColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: showError && initialValue.isEmpty
                    ? AppColors.redColor
                    : AppColors.greyColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: showError && initialValue.isEmpty
                    ? AppColors.redColor
                    : AppColors.greyColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: showError && initialValue.isEmpty
                    ? AppColors.redColor
                    : AppColors.greyColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorText:
                showError && initialValue.isEmpty ? emptyTextField : null,
          ),
          style: ShippingAddressEditingPageTextStyles.textFieldInputTextStyle,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _updateShippingInfo(
    BuildContext context, {
    String? fullName,
    String? address,
    String? city,
    String? postalCode,
    String? phone,
  }) {
    final state = context.read<ShippingBloc>().state;

    context.read<ShippingBloc>().add(
          UpdateShippingInfoEvent(
            fullName: fullName ?? state.fullName,
            address: address ?? state.address,
            city: city ?? state.city,
            postalCode: postalCode ?? state.postalCode,
            phone: phone ?? state.phone,
          ),
        );
  }
}
