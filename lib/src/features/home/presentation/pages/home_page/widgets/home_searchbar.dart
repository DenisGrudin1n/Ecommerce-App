import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 88,
          ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: AppIcons.searchIcon,
                  onPressed: () {
                    final query = context.read<HomeBloc>().currentQuery;
                    context
                        .read<HomeBloc>()
                        .add(LoadFeaturedProductsEvent(query));
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      context.read<HomeBloc>().currentQuery =
                          query; // Update the currentQuery
                      context
                          .read<HomeBloc>()
                          .add(LoadFeaturedProductsEvent(query));
                    },
                    decoration: InputDecoration(
                      hintText:
                          context.localization.homePageWhatAreYouLookingForText,
                      hintStyle:
                          HomePageTextStyles.homeWhatAreYouLookingforTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
