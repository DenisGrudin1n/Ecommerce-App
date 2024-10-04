import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/profile_page/bloc/profile_bloc.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

@RoutePage()
class MainTabsPage extends StatefulWidget {
  const MainTabsPage({super.key});

  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {
  final favoritesBox = Hive.box<int>('favorites');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FavoriteBloc(favoritesBox)..add(LoadFavoriteProductsEvent()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          )
            ..add(const LoadFeaturedProductsEvent(''))
            ..add(LoadHomeCatalogueEvent())
            ..add(LoadFashionSaleImagesEvent()),
        ),
        BlocProvider(
          create: (context) => CatalogueBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          )..add(const LoadCatalogueItemsEvent('')),
        ),
        BlocProvider(
          create: (context) => ItemsBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          )
            ..add(const LoadItemsEvent(''))
            ..add(LoadItemsCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FilterBloc(
            firestoreRepository: context.read<DatabaseRepository>(),
          ),
        ),
      ],
      child: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          CatalogueRoute(),
          ItemsRoute(),
          FavoriteRoute(),
          ProfileRoute(),
          FilterRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return AppBottomNavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
          );
        },
      ),
    );
  }
}
