import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/constants/keys.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  bool _isCartClosed = true;
  Timer? _closeCartTimer;

  @override
  void dispose() {
    _closeCartTimer?.cancel();
    super.dispose();
  }

  void _startCloseCartTimer() {
    _closeCartTimer?.cancel();
    _closeCartTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isCartClosed = true;
      });
    });
  }

  void _toggleCart() {
    setState(() {
      if (_isCartClosed) {
        _isCartClosed = false;
        _startCloseCartTimer();
      } else {
        context.router.push(const CartRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final products = context.select((CartBloc bloc) => bloc.state.products);
    var totalPrice = 0.0;
    for (final product in products) {
      totalPrice += product.productPrice * product.counter;
    }

    return Container(
      height: 105,
      color: AppColors.lightBackgroundColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 85,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(bottom: 20, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildIcon(
                      BottomNavBarKeys.home,
                      context.localization.bottomNavBarHomeText,
                      0,
                      tabsRouter,
                    ),
                    buildIcon(
                      BottomNavBarKeys.catalogue,
                      context.localization.bottomNavBarCatalogueText,
                      1,
                      tabsRouter,
                    ),
                    buildIcon(
                      BottomNavBarKeys.favorite,
                      context.localization.bottomNavBarFavoriteText,
                      3,
                      tabsRouter,
                    ),
                    buildIcon(
                      BottomNavBarKeys.profile,
                      context.localization.bottomNavBarProfileText,
                      4,
                      tabsRouter,
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: _isCartClosed ? 0 : 400,
                      ),
                      curve: Curves.easeInOut,
                      width: _isCartClosed ? 45 : 105,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 45,
            child: buildCartButton(totalPrice, products.length),
          ),
        ],
      ),
    );
  }

  Widget buildIcon(
    String iconKey,
    String label,
    int index,
    TabsRouter tabsRouter,
  ) {
    final isSelected = widget.selectedIndex == index;
    final iconWidget = isSelected
        ? getActiveBottomNavBarIcon(iconKey)
        : getInactiveBottomNavBarIcon(iconKey);

    final labelWidget = isSelected
        ? GradientText(
            text: label,
            style: BottomNavBarTextStyles.bottomNavBarActiveIconTextStyle,
            gradient: AppGradients.purpleGradient,
          )
        : Text(
            label,
            style: BottomNavBarTextStyles.bottomNavBarNotActiveIconTextStyle,
          );

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap(index);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const SizedBox(
            height: 4,
          ),
          labelWidget,
        ],
      ),
    );
  }

  Widget buildCartButton(double totalPrice, int productsLength) {
    final itemText = context.localization.bottomNavBarShoppingCartItemText;
    final itemsText = context.localization.bottomNavBarShoppingCartItemsText;

    return GestureDetector(
      onTap: _toggleCart,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: _isCartClosed ? 0 : 400,
        ),
        curve: Curves.easeInOut,
        height: 60,
        width: _isCartClosed ? 65 : 120,
        decoration: const BoxDecoration(
          gradient: AppGradients.purpleGradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        child: _isCartClosed
            ? AppIcons.shoppingCartIcon
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AppIcons.shoppingCartIcon,
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: BottomNavBarTextStyles
                              .bottomNavBarShoppingCartPriceTextStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          productsLength == 1
                              ? '$productsLength $itemText'
                              : '$productsLength $itemsText',
                          style: BottomNavBarTextStyles
                              .bottomNavBarShoppingCartItemCountTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static Widget getActiveBottomNavBarIcon(String key) {
    return switch (key) {
      BottomNavBarKeys.home => AppIcons.homeActiveIcon,
      BottomNavBarKeys.catalogue => AppIcons.catalogueActiveIcon,
      BottomNavBarKeys.favorite => AppIcons.favoriteActiveIcon,
      BottomNavBarKeys.profile => AppIcons.profileActiveIcon,
      _ => const SizedBox(),
    };
  }

  static Widget getInactiveBottomNavBarIcon(String key) {
    return switch (key) {
      BottomNavBarKeys.home => AppIcons.homeNotActiveIcon,
      BottomNavBarKeys.catalogue => AppIcons.catalogueNotActiveIcon,
      BottomNavBarKeys.favorite => AppIcons.favoriteNotActiveIcon,
      BottomNavBarKeys.profile => AppIcons.profileNotActiveIcon,
      _ => const SizedBox(),
    };
  }
}
