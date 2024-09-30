import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

class FavoriteAppbar extends StatelessWidget {
  const FavoriteAppbar({super.key});

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
      child: Row(
        children: [
          IconButton(
            icon: AppIcons.arrowBackIcon,
            onPressed: () {
              context.router.push(const ItemsRoute());
            },
          ),
          Text(
            context.localization.filterPageFilterText,
            style: CataloguePageTextStyles.catalogueTextStyle,
          ),
        ],
      ),
    );
  }
}
