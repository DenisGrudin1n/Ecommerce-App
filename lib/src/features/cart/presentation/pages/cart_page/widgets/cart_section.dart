import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.select<ProductBloc, int>(
      (bloc) => bloc.state.counter,
    );

    return Column(
      children: [
        Container(
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
                  child: const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkColor,
                        height: 19 / 14,
                        letterSpacing: -0.15,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '\$${(87 * counter).toStringAsFixed(2)}',
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
                      context.read<ProductBloc>().add(IncrementCounterEvent());
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppColors.greyColor,
                  ),
                  Text(
                    counter.toString(),
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
                      context.read<ProductBloc>().add(DecrementCounterEvent());
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        Container(
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
                  child: const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkColor,
                        height: 19 / 14,
                        letterSpacing: -0.15,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '\$${(87 * counter).toStringAsFixed(2)}',
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
                      context.read<ProductBloc>().add(IncrementCounterEvent());
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppColors.greyColor,
                  ),
                  Text(
                    counter.toString(),
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
                      context.read<ProductBloc>().add(DecrementCounterEvent());
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
