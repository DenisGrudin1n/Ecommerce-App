import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/widgets/cart_appbar.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/widgets/cart_section.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/widgets/checkout_window.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: CartAppbar()),
                SliverFillRemaining(
                  child: RefreshableScrollView(
                    refreshController: refreshController,
                    onRefresh: () async {
                      refreshController.refreshCompleted();
                    },
                    slivers: const [
                      SliverToBoxAdapter(
                        child: CartSection(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CheckoutWindow(),
            ),
          ],
        ),
      ),
    );
  }
}
