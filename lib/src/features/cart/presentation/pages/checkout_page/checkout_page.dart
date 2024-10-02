import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/checkout_appbar.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/checkout_section.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/pay_window.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: CheckoutAppbar()),
              SliverFillRemaining(
                child: RefreshableScrollView(
                  refreshController: refreshController,
                  onRefresh: () async {
                    refreshController.refreshCompleted();
                  },
                  slivers: const [
                    SliverToBoxAdapter(
                      child: CheckoutSection(),
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
            child: PayWindow(),
          ),
        ],
      ),
    );
  }
}
