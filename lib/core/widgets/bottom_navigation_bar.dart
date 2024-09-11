import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/constants/keys.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  bool _isCartClosed = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const BottomNavEvent(BottomNavTab.home));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is BottomNavState) {
          return SizedBox(
            height: 105,
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
                            BottomNavTab.home,
                            state.selectedTab,
                            context,
                          ),
                          buildIcon(
                            BottomNavBarKeys.catalogue,
                            context.localization.bottomNavBarCatalogueText,
                            BottomNavTab.catalogue,
                            state.selectedTab,
                            context,
                          ),
                          buildIcon(
                            BottomNavBarKeys.favorite,
                            context.localization.bottomNavBarFavoriteText,
                            BottomNavTab.favorite,
                            state.selectedTab,
                            context,
                          ),
                          buildIcon(
                            BottomNavBarKeys.profile,
                            context.localization.bottomNavBarProfileText,
                            BottomNavTab.profile,
                            state.selectedTab,
                            context,
                          ),
                          SizedBox(width: _isCartClosed ? 45 : 105),
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
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildIcon(
    String iconKey,
    String label,
    BottomNavTab tab,
    BottomNavTab selectedTab,
    BuildContext context,
  ) {
    final isSelected = selectedTab == tab;
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
        context.read<HomeBloc>().add(BottomNavEvent(tab));

        switch (tab) {
          case BottomNavTab.home:
            context.router.replace(const HomeRoute());
          case BottomNavTab.catalogue:
            context.router.replace(const CatalogueRoute());
          case BottomNavTab.favorite:
            break;
          case BottomNavTab.profile:
            break;
        }
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

  Widget buildCartButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCartClosed = !_isCartClosed;
        });
      },
      child: Container(
        height: 60,
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
