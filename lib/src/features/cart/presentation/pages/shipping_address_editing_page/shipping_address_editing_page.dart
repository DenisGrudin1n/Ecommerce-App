import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/widgets/shipping_appbar.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/widgets/shipping_textfields.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShippingAddressEditingPage extends StatelessWidget {
  const ShippingAddressEditingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Column(
        children: [
          ShippingAppbar(),
          ShippingTextFields(),
        ],
      ),
    );
  }
}
