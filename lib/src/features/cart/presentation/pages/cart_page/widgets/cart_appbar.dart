import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAppbar extends StatelessWidget {
  const CartAppbar({super.key});

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
              context.localization.cartPageCartText,
              style: CataloguePageTextStyles.catalogueTextStyle,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  context.read<CartBloc>().add(RemoveAllCartProductsEvent());
                },
                child: Text(
                  context.localization.cartPageRemoveAllText,
                  style: FilterPageTextStyles.clearTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
