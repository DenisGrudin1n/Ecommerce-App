// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CataloguePage]
class CatalogueRoute extends PageRouteInfo<void> {
  const CatalogueRoute({List<PageRouteInfo>? children})
      : super(
          CatalogueRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogueRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CataloguePage();
    },
  );
}

/// generated route for
/// [EnterPhonePage]
class EnterPhoneRoute extends PageRouteInfo<void> {
  const EnterPhoneRoute({List<PageRouteInfo>? children})
      : super(
          EnterPhoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'EnterPhoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EnterPhonePage();
    },
  );
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritePage();
    },
  );
}

/// generated route for
/// [FilterPage]
class FilterRoute extends PageRouteInfo<void> {
  const FilterRoute({List<PageRouteInfo>? children})
      : super(
          FilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FilterPage();
    },
  );
}

/// generated route for
/// [GetStartedPage]
class GetStartedRoute extends PageRouteInfo<void> {
  const GetStartedRoute({List<PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GetStartedPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [ItemsPage]
class ItemsRoute extends PageRouteInfo<void> {
  const ItemsRoute({List<PageRouteInfo>? children})
      : super(
          ItemsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ItemsPage();
    },
  );
}

/// generated route for
/// [MainTabsPage]
class MainTabsRoute extends PageRouteInfo<void> {
  const MainTabsRoute({List<PageRouteInfo>? children})
      : super(
          MainTabsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainTabsPage();
    },
  );
}

/// generated route for
/// [ProductPage]
class ProductRoute extends PageRouteInfo<void> {
  const ProductRoute({List<PageRouteInfo>? children})
      : super(
          ProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [VerificationPage]
class VerificationRoute extends PageRouteInfo<VerificationRouteArgs> {
  VerificationRoute({
    required String phoneNumber,
    required String phoneCode,
    required String verificationId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          VerificationRoute.name,
          args: VerificationRouteArgs(
            phoneNumber: phoneNumber,
            phoneCode: phoneCode,
            verificationId: verificationId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'VerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationRouteArgs>();
      return VerificationPage(
        phoneNumber: args.phoneNumber,
        phoneCode: args.phoneCode,
        verificationId: args.verificationId,
        key: args.key,
      );
    },
  );
}

class VerificationRouteArgs {
  const VerificationRouteArgs({
    required this.phoneNumber,
    required this.phoneCode,
    required this.verificationId,
    this.key,
  });

  final String phoneNumber;

  final String phoneCode;

  final String verificationId;

  final Key? key;

  @override
  String toString() {
    return 'VerificationRouteArgs{phoneNumber: $phoneNumber, phoneCode: $phoneCode, verificationId: $verificationId, key: $key}';
  }
}
