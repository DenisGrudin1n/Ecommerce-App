import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShippingAddressEditingPage extends StatelessWidget {
  const ShippingAddressEditingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Text(
          'Shipping Address Editing Page',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
