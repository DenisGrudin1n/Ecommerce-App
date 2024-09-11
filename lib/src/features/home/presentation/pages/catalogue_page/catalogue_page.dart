import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_list.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_searchbar.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // AppBar & SearchBar
          Stack(
            children: [
              const CatalogueAppbar(),
              BlocProvider(
                create: (context) => HomeBloc(
                  storageRepository: context.read<StorageRepository>(),
                  firestoreRepository: context.read<DatabaseRepository>(),
                ),
                child: const CatalogueSearchBar(),
              ),
            ],
          ),

          // Catalogue List
          BlocProvider(
            create: (context) => HomeBloc(
              storageRepository: context.read<StorageRepository>(),
              firestoreRepository: context.read<DatabaseRepository>(),
            ),
            child: const CatalogueList(),
          ),
        ],
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => HomeBloc(
          storageRepository: context.read<StorageRepository>(),
          firestoreRepository: context.read<DatabaseRepository>(),
        ),
        child: const AppBottomNavigationBar(),
      ),
    );
  }
}
