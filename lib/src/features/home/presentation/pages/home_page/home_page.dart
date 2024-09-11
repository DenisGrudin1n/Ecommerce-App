import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/widgets/catalogue_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/widgets/fashion_sale_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/widgets/featured_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/widgets/home_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/widgets/home_searchbar.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      )
        ..add(const LoadFeaturedProductsEvent(''))
        ..add(LoadHomeCatalogueEvent())
        ..add(LoadFashionSaleImagesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.lightGreyColor,
        body: Builder(
          builder: (BuildContext context) {
            final refreshController = RefreshController();

            return CustomScrollView(
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
                SliverFillRemaining(
                  child: RefreshableScrollView(
                    refreshController: refreshController,
                    onRefresh: () async {
                      // Dispatch events to refresh the data
                      context
                          .read<HomeBloc>()
                          .add(const LoadFeaturedProductsEvent(''));
                      context.read<HomeBloc>().add(LoadHomeCatalogueEvent());
                      context
                          .read<HomeBloc>()
                          .add(LoadFashionSaleImagesEvent());
                      // Complete the refresh
                      refreshController.refreshCompleted();
                    },
                    slivers: [
                      // Fashion Sale Section
                      const SliverToBoxAdapter(
                        child: FashionSaleSection(),
                      ),

                      const SliverPadding(padding: EdgeInsets.only(top: 20)),

                      // Catalogue Section
                      const SliverToBoxAdapter(
                        child: CatalogueSection(),
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
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: FeaturedSection(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
