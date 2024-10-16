import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/shadows.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/bloc/shipping_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = context.select<CheckoutBloc, String>(
      (bloc) => bloc.state.selectedPaymentMethod,
    );

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          _buildShippingInfo(
            fullName: fullName,
            address: address,
            city: city,
            postalCode: postalCode,
            phone: phone,
            context: context,
          ),
          const SizedBox(
            height: 33,
          ),
          _buildDeliveryMethod(context, selectedPaymentMethod),
          const SizedBox(
            height: 33,
          ),
          _buildPaymentMethod(context),
        ],
      ),
    );
  }

  Widget _buildShippingInfo({
    required String fullName,
    required String address,
    required String city,
    required String postalCode,
    required String phone,
    required BuildContext context,
  }) {
    final cityParts = city.split(',');
    city = cityParts.isNotEmpty ? cityParts[0].trim() : '';
    final country = cityParts.length > 1 ? cityParts[1].trim() : '';
    return Column(
      children: [
        Row(
          children: [
            AppIcons.locationGradientIcon,
            const SizedBox(
              width: 12,
            ),
            Text(
              context.localization.checkoutPageShippingAddressText,
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 12, bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              AppShadows.defaultContainerBoxShadow,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    fullName.isEmpty
                        ? context
                            .localization.checkoutPageNoShippingAddressDataText
                        : fullName,
                    style: ProductPageTextStyles.productPageUserNameTextStyle,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.router.push(const ShippingAddressEditingRoute());
                    },
                    child: Row(
                      children: [
                        GradientText(
                          text: context.localization.checkoutPageChangeText,
                          style: CheckoutPageTextStyles.changeTextStyle,
                          gradient: AppGradients.purpleGradient,
                        ),
                        AppIcons.arrowForwardGradientIcon,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                address.isEmpty ? '' : address,
                style: CheckoutPageTextStyles.addressTextStyle,
              ),
              Text(
                '${city.isEmpty ? '' : '$city,'} '
                '${postalCode.isEmpty ? '' : 'IL $postalCode,'} '
                '${country.isEmpty ? '' : country}',
                style: CheckoutPageTextStyles.addressTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryMethod(
    BuildContext context,
    String selectedPaymentMethod,
  ) {
    return Column(
      children: [
        Row(
          children: [
            AppIcons.localShippingGradientIcon,
            const SizedBox(width: 12),
            Text(
              context.localization.checkoutPageDeliveryMethodText,
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPaymentOption(
              context,
              'DHL',
              r'$15',
              '1-2 ${context.localization.checkoutPageDaysText}',
              selectedPaymentMethod,
            ),
            _buildPaymentOption(
              context,
              'FedEx',
              r'$18',
              '1-2 ${context.localization.checkoutPageDaysText}',
              selectedPaymentMethod,
            ),
            _buildPaymentOption(
              context,
              'USPS',
              r'$20',
              '1-2 ${context.localization.checkoutPageDaysText}',
              selectedPaymentMethod,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String paymentMethod,
    String price,
    String time,
    String selectedPaymentMethod,
  ) {
    final isSelected = selectedPaymentMethod == paymentMethod;

    return GestureDetector(
      onTap: () {
        context
            .read<CheckoutBloc>()
            .add(UpdatePaymentMethodEvent(paymentMethod));
      },
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 12, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? AppColors.yellowColor : AppColors.transparentColor,
            width: 2,
          ),
          boxShadow: [
            AppShadows.defaultContainerBoxShadow,
          ],
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                getPaymentImagePath(paymentMethod),
              ),
              height: 16,
              width: 71,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: ProductPageTextStyles.productPageUserNameTextStyle,
            ),
            Text(
              time,
              style: ProductPageTextStyles.productPageHelpfulTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppIcons.creditCardGradientIcon,
            const SizedBox(
              width: 12,
            ),
            Text(
              context.localization.checkoutPagePaymentMethodText,
              style: ProductPageTextStyles.productDetailsStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              AppShadows.defaultContainerBoxShadow,
            ],
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(Assets.images.mastercard.path),
                height: 27,
                width: 36,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '**** **** **** 5678',
                style: CheckoutPageTextStyles.cardNumberTextStyle,
              ),
              const Spacer(),
              GradientText(
                text: context.localization.checkoutPageChangeText,
                style: CheckoutPageTextStyles.changeTextStyle,
                gradient: AppGradients.purpleGradient,
              ),
              AppIcons.arrowForwardGradientIcon,
            ],
          ),
        ),
      ],
    );
  }

  String getPaymentImagePath(String paymentMethod) => switch (paymentMethod) {
        'DHL' => Assets.images.item1.path,
        'FedEx' => Assets.images.item2.path,
        _ => Assets.images.item3.path,
      };
}
