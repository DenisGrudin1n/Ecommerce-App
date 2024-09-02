import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/home_bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/catalogue_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/fashion_sale_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/featured_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_searchbar.dart';
import 'package:ecommerce_app/src/features/home/repositories/firebase_storage_repository.dart';
import 'package:ecommerce_app/src/features/home/repositories/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storageRepository = StorageRepository(FirebaseStorageRepository());

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Stack(
              children: [
                HomeAppbar(),
                HomeSearchBar(),
              ],
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (_) =>
                  ImageLoaderBloc(storageRepository: storageRepository),
              child: const FashionSaleSection(),
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (_) =>
                  ImageLoaderBloc(storageRepository: storageRepository),
              child: const CatalogueSection(),
            ),
            const SizedBox(height: 20),
            const FeaturedSection(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}
