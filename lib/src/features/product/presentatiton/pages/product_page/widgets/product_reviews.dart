import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                context.localization.productPageReviewsText,
                style: HomePageTextStyles.homePageCatalogueTextStyle,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    context.localization.productPageSeeAllText,
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
          Text(
            context.localization.productPageUserNameText,
            style: ProductPageTextStyles.productPageUserNameTextStyle,
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
              Text(
                context.localization.productPageDateText,
                style: ProductPageTextStyles.productPageDateTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            context.localization.productPageFullCommentText,
            style: ProductPageTextStyles.productPageFullCommentTextStyle,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            context.localization.productPagePeopleFoundHelpfulText,
            style: ProductPageTextStyles.productPagePeopleFoundHelpfulTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                context.localization.productPageCommentText,
                style: ProductPageTextStyles.productPageCommentTextStyle,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    context.localization.productPageHelpfulText,
                    style: ProductPageTextStyles.productPageHelpfulTextStyle,
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
                            ? AppIcons.productPageThumbsUpIcon
                            : AppIcons.productPageThumbsUpOutlinedIcon,
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
