import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

class ItemsAppbar extends StatelessWidget {
  const ItemsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Stack(
          children: [
            Align(
              child: Text(
                context.localization.cataloguePageCatalogueText,
                style: CataloguePageTextStyles.catalogueTextStyle,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: AppIcons.arrowBackIcon,
                  onPressed: () {
                    context.router.push(const HomeRoute());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
