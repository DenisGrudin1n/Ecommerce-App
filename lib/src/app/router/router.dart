import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/cart_page.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/checkout_page.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/shipping_address_editing_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/catalogue_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/favorite_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/filter_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/home_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/items_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/main_tabs_page.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/profile_page.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page/enter_phone_page.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page/get_started_page.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/verification_page/verification_page.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/product_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: GetStartedRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: EnterPhoneRoute.page,
        ),
        AutoRoute(
          page: VerificationRoute.page,
        ),
        AutoRoute(
          page: MainTabsRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(page: CatalogueRoute.page),
            AutoRoute(
              page: ItemsRoute.page,
            ),
            AutoRoute(
              page: FavoriteRoute.page,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
            AutoRoute(
              page: FilterRoute.page,
            ),
          ],
        ),

        AutoRoute(
          page: ProductRoute.page,
        ),
        AutoRoute(
          page: CartRoute.page,
        ),
        AutoRoute(
          page: CheckoutRoute.page,
        ),
        AutoRoute(
          page: ShippingAddressEditingRoute.page,
        ),
      ];
}
