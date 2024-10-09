import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/cart_page/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartSection extends StatefulWidget {
  const CartSection({super.key});

  @override
  State<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection> {
  @override
  void initState() {
    context.read<CartBloc>().add(LoadCartProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.select((CartBloc bloc) => bloc.state.products);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final product = products[index];
          final productPrice = product.productPrice * product.counter;
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkColor.withOpacity(0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(product.imageUrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkColor,
                            height: 19 / 14,
                            letterSpacing: -0.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${productPrice.toStringAsFixed(2)}',
                          style: HomePageTextStyles
                              .homePageFeaturedProductDarkPriceTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                IncrementCartCounterEvent(product.imageUrl),
                              );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.greyColor,
                      ),
                      Text(
                        product.counter.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGreyColor,
                          height: 19 / 14,
                          letterSpacing: -0.15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                DecrementCartCounterEvent(product.imageUrl),
                              );
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        childCount: products.length,
      ),
    );
  }
}
