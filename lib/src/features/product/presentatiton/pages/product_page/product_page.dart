import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/product_appbar.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/widgets/product_details.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      )..add(LoadAppbarProductsEvent()),
      child: const Scaffold(
        backgroundColor: AppColors.lightGreyColor,
        body: CustomScrollView(
          slivers: [
            // AppBar & SearchBar
            SliverToBoxAdapter(child: ProductAppbar()),
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: 8,
              ),
            ),
            SliverToBoxAdapter(
              child: ProductDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
