import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_list.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/catalogue_searchbar.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogueBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightGreyColor,
        body: Column(
          children: [
            // AppBar & SearchBar
            const Stack(
              children: [
                CatalogueAppbar(),
                CatalogueSearchBar(),
              ],
            ),
            Expanded(
              child: Builder(
                builder: (BuildContext context) {
                  final refreshController = RefreshController();

                  return RefreshableScrollView(
                    refreshController: refreshController,
                    onRefresh: () async {
                      // Dispatch events to refresh the data
                      context.read<CatalogueBloc>().add(LoadCatalogueEvent());
                      // Complete the refresh
                      refreshController.refreshCompleted();
                    },
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        // Catalogue List
                        CatalogueList(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
