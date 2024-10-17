import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/refreshable_scroll_view.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/bloc/checkout_bloc.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/checkout_appbar.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/checkout_section.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/pay_window.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/checkout_page/widgets/success_window.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  late RefreshController _refreshController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final cartBox = Hive.box<CartProduct>('cart');

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            firestoreRepository: context.read<DatabaseRepository>(),
          )..add(LoadCartProductsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.showSuccessWindow) {
              _animationController
                ..reset()
                ..forward();
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: CheckoutAppbar()),
                  SliverFillRemaining(
                    child: RefreshableScrollView(
                      refreshController: _refreshController,
                      onRefresh: () async {
                        _refreshController.refreshCompleted();
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
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Stack(
                      children: [
                        ModalBarrier(
                          dismissible: false,
                          color: AppColors.blackColor.withOpacity(0.5),
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    );
                  }

                  if (state.showSuccessWindow) {
                    return Stack(
                      children: [
                        ModalBarrier(
                          dismissible: false,
                          color: AppColors.blackColor.withOpacity(0.5),
                        ),
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: const Center(
                            child: SuccessWindow(),
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
