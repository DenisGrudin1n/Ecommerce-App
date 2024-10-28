import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_list.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
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
      body: Column(
        children: [
          // AppBar & SearchBar
          Stack(
            children: [
              const CatalogueAppbar(),
              CatalogueSearchBar(
                controller: searchController,
              ),
            ],
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                return RefreshableScrollView(
                  refreshController: refreshController,
                  onRefresh: () async {
                    // Clear search query
                    searchController.clear();
                    // Dispatch events to refresh the data
                    context
                        .read<CatalogueBloc>()
                        .add(const LoadCatalogueItemsEvent(''));
                    // Complete the refresh
                    refreshController.refreshCompleted();
                  },
                  child: const CatalogueList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
