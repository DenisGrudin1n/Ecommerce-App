import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/bloc/favorite_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/widgets/favorite_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/favorite_page/widgets/favorite_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: [
              // AppBar & SearchBar
              const SliverToBoxAdapter(
                child: FavoriteAppbar(),
              ),

              const SliverPadding(padding: EdgeInsets.only(top: 24)),

              // Pull to refresh feature
              SliverFillRemaining(
                child: RefreshableScrollView(
                  refreshController: refreshController,
                  onRefresh: () async {
                    context
                        .read<FavoriteBloc>()
                        .add(LoadFavoriteProductsEvent());
                    refreshController.refreshCompleted();
                  },
                  slivers: const [
                    // Items Section as SliverGrid
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: FavoriteSection(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
