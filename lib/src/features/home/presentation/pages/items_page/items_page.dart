import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_categories.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_searchbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late TextEditingController searchController;
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    refreshController = RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    const ItemsAppbar(),
                    ItemsSearchBar(controller: searchController),
                  ],
                ),
              ),

              const SliverPadding(padding: EdgeInsets.only(top: 20)),

              SliverToBoxAdapter(
                child: ItemsCategories(
                  onCategorySelected: (categoryName) {
                    context
                        .read<ItemsBloc>()
                        .add(ChangeItemsCategoryEvent(categoryName));
                  },
                ),
              ),

              const SliverPadding(padding: EdgeInsets.only(top: 24)),

              // Pull to refresh feature
              SliverFillRemaining(
                child: RefreshableScrollView(
                  refreshController: refreshController,
                  onRefresh: () async {
                    // Clear search query
                    searchController.clear();
                    // Dispatch events to refresh the data
                    context.read<ItemsBloc>().add(const LoadItemsEvent(''));
                    context.read<ItemsBloc>().add(LoadItemsCategoriesEvent());
                    // Complete the refresh
                    refreshController.refreshCompleted();
                  },
                  slivers: const [
                    // Items Section as SliverGrid
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: ItemsSection(),
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
