import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_categories.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_searchbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/widgets/items_section.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
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
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      )
        ..add(const LoadItemsEvent(''))
        ..add(LoadItemsCategoriesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.lightGreyColor,
        body: Builder(
          builder: (BuildContext context) {
            final searchController = TextEditingController();
            final refreshController = RefreshController();

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
                      setState(() {
                        selectedCategory = categoryName;
                      });
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
                    slivers: [
                      // Items Section as SliverGrid
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Text('166 items'),
                              Spacer(),
                              Row(
                                children: [
                                  Text('Sort by: '),
                                  Text('Featured '),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: ItemsSection(
                          selectedCategory: selectedCategory,
                        ),
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
