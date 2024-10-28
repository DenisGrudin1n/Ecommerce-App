import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CheckoutAppbar extends StatelessWidget {
  const CheckoutAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 30,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: AppIcons.arrowBackIcon,
                onPressed: () {
                  context.router.back();
                },
              ),
            ),
          ),
          Align(
            child: Text(
              context.localization.checkoutPageCheckoutText,
              style: CataloguePageTextStyles.catalogueTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
