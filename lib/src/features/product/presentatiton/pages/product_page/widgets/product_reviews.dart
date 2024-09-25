import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final isCommentHelpful = context.select<ProductBloc, bool>(
      (bloc) => bloc.state.isCommentHelpful,
    );
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Reviews',
                style: HomePageTextStyles.homePageCatalogueTextStyle,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'See All',
                    style: HomePageTextStyles.homePageSeeAllTextStyle,
                  ),
                  AppIcons.seeAllIcon,
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Olha Chabanova',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 27, 22, 31),
              height: 19 / 14,
              letterSpacing: -0.15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (starIndex) => AppIcons.productPageStarIcon,
                ),
              ),
              const Spacer(),
              const Text(
                'June 5, 2021',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkColor,
                  height: 19 / 14,
                  letterSpacing: -0.15,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'I’m old (rolling through my 50’s). But, this is my daughter in law’s favorite color right now.❤️ So I wear it whenever we hang out! She’s my fashion consultant who keeps me on trend🤣',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor.withOpacity(0.4),
              height: 19 / 14,
              letterSpacing: -0.15,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            '835 people found this helpful',
            style: TextStyle(
              fontFamily: 'SFProText',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
              height: 13 / 11,
              letterSpacing: 0.07,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text(
                'Comment',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.darkColor,
                  height: 19 / 14,
                  letterSpacing: -0.15,
                  decoration: TextDecoration.underline,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text(
                    'Helpful',
                    style: TextStyle(
                      fontFamily: 'SFProText',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                      height: 16 / 13,
                      letterSpacing: 0,
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<ProductBloc>().add(
                                ToggleCommentHelpfulEvent(),
                              );
                        },
                        icon: isCommentHelpful
                            ? const Icon(
                                Icons.thumb_up,
                                size: 24,
                                color: AppColors.blueColor,
                              )
                            : const Icon(
                                Icons.thumb_up_outlined,
                                size: 24,
                                color: AppColors.greyColor,
                              ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
