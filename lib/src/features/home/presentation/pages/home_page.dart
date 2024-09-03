import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/core/widgets/home_bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/catalogue_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/fashion_sale_section.dart';
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

          const SliverPadding(padding: EdgeInsets.only(top: 10)),

          // Featured Section as SliverGrid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildFeaturedItem();
                },
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }

  Widget _buildFeaturedItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 10,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 10,
            color: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}
