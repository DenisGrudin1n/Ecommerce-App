import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Text(
          'Favorite Page',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
