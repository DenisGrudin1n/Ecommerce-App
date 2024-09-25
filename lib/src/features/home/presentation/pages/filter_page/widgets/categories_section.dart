import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(LoadCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select<FilterBloc, List<ItemsCategoriesModel>>(
      (bloc) => bloc.state.categories,
    );
    final isLoadingCategories = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isLoadingCategories,
    );
    final categoriesErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.categoriesErrorMessage,
    );
    final selectedCategory = context.select<FilterBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );
    final isDropdownOpen = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isCategoryDropdownOpen,
    );

    if (isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categories.isEmpty) {
      return Text(context.localization.noItemsFoundText);
    }

    if (categoriesErrorMessage.isNotEmpty) {
      return Center(child: Text(categoriesErrorMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.filterPageCategoriesText,
          style: FilterPageTextStyles.sectionNameTextStyle,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            context.read<FilterBloc>().add(ToggleCategoryDropdownEvent());
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyColor, width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedCategory,
                    overflow: TextOverflow.ellipsis,
                    style: FilterPageTextStyles.valueTextStyle,
                  ),
                ),
                if (isDropdownOpen)
                  AppIcons.filterPageCategoriesOpenedIcon
                else
                  AppIcons.filterPageCategoriesNotOpenedIcon,
              ],
            ),
          ),
        ),
        if (isDropdownOpen) ...[
          const SizedBox(height: 8),
          ...categories.map(
            (category) => GestureDetector(
              onTap: () {
                context
                    .read<FilterBloc>()
                    .add(ChangeCategoryEvent(category.name));
                context.read<FilterBloc>().add(ToggleCategoryDropdownEvent());
              },
              child: Container(
                width: 175,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.greyColor,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        category.name,
                        overflow: TextOverflow.ellipsis,
                        style: FilterPageTextStyles.valueTextStyle,
                      ),
                    ),
                    if (selectedCategory == category.name)
                      const Icon(
                        Icons.check,
                        color: AppColors.greyColor,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
