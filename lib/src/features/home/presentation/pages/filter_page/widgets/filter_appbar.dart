import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterAppbar extends StatelessWidget {
  const FilterAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 30,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: AppIcons.arrowBackIcon,
            onPressed: () {
              context.router.push(const ItemsRoute());
            },
          ),
          Text(
            context.localization.filterPageFilterText,
            style: CataloguePageTextStyles.catalogueTextStyle,
          ),
          GestureDetector(
            onTap: () {
              context.read<FilterBloc>().add(ClearFiltersEvent());
            },
            child: Text(
              context.localization.filterPageClearText,
              style: FilterPageTextStyles.clearTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
