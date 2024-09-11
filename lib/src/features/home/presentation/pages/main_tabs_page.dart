import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainTabsPage extends StatelessWidget {
  const MainTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        CatalogueRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return AppBottomNavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
        );
      },
    );
  }
}
