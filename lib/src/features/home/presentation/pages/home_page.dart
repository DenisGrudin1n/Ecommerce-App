import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/core/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/catalogue_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/fashion_sale_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/featured_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_searchbar.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // AppBar & SearchBar
          const SliverToBoxAdapter(
            child: Stack(
              children: [
                HomeAppbar(),
                HomeSearchBar(),
              ],
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          // Fashion Sale Section
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => ImageLoaderBloc(
                storageRepository: context.read<StorageRepository>(),
              ),
              child: const FashionSaleSection(),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          // Catalogue Section
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => ImageLoaderBloc(
                storageRepository: context.read<StorageRepository>(),
              ),
              child: const CatalogueSection(),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                context.localization.homePageFeaturedText,
                style: HomePageTextStyles.homePageFeaturedTextStyle,
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 16)),

          // Featured Section as SliverGrid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: BlocProvider(
              create: (context) => ImageLoaderBloc(
                storageRepository: context.read<StorageRepository>(),
              ),
              child: const FeaturedSection(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
