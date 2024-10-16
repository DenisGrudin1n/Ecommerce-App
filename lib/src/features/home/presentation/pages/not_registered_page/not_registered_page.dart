import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotRegisteredPage extends StatelessWidget {
  const NotRegisteredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login,
                  size: 64,
                  color: AppColors.darkColor,
                ),
                SizedBox(
                  width: 25,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              context.localization.errorLoginRequiredMessage,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.router.push(const EnterPhoneRoute());
              },
              child: Text(
                context.localization.loginText,
                style: const TextStyle(
                  color: AppColors.darkColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
