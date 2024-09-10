import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Text(
          'Items Page',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
