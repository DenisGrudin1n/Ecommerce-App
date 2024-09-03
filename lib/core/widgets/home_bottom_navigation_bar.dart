import 'package:ecommerce_app/core/constants/keys.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _selectedIndex = 0;
  bool _isCartClosed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      color: AppColors.transparentColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 85,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(bottom: 25),
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
                    ),
                    buildIcon(
                      BottomNavBarKeys.catalogue,
                      context.localization.bottomNavBarCatalogueText,
                      1,
                    ),
                    buildIcon(
                      BottomNavBarKeys.favorite,
                      context.localization.bottomNavBarFavoriteText,
                      2,
                    ),
                    buildIcon(
                      BottomNavBarKeys.profile,
                      context.localization.bottomNavBarProfileText,
                      3,
                    ),
                    SizedBox(width: _isCartClosed ? 50 : 110),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 45,
            child: buildCartButton(),
          ),
        ],
      ),
    );
  }

  Widget buildIcon(String iconKey, String label, int index) {
    final isSelected = _selectedIndex == index;
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
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          labelWidget,
        ],
      ),
    );
  }

  Widget buildCartButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCartClosed = !_isCartClosed;
        });
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: AppGradients.purpleGradient,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 10,
        ),
        child: _isCartClosed
            ? AppIcons.shoppingCartIcon
            : Row(
                children: [
                  AppIcons.shoppingCartIcon,
                  const SizedBox(
                    width: 4,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.localization.bottomNavBarShoppingCartPriceText,
                        style: BottomNavBarTextStyles
                            .bottomNavBarShoppingCartPriceTextStyle,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        context.localization.bottomNavBarShoppingCartItemText,
                        style: BottomNavBarTextStyles
                            .bottomNavBarShoppingCartItemCountTextStyle,
                      ),
                    ],
                  ),
                ],
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
