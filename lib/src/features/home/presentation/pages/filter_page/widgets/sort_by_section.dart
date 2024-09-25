import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/sort_by_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortBySection extends StatefulWidget {
  const SortBySection({super.key});

  @override
  State<SortBySection> createState() => _SortBySectionState();
}

class _SortBySectionState extends State<SortBySection> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(LoadSortByEvent());
  }

  @override
  Widget build(BuildContext context) {
    final sortBy = context.select<FilterBloc, List<SortByModel>>(
      (bloc) => bloc.state.sortBy,
    );
    final isLoadingSortBy = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isLoadingSortBy,
    );
    final sortByErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.sortByErrorMessage,
    );
    final selectedSortBy = context.select<FilterBloc, String>(
      (bloc) => bloc.state.selectedSortBy,
    );
    final isDropdownOpen = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isSortByDropdownOpen,
    );

    if (isLoadingSortBy) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sortBy.isEmpty) {
      return Text(context.localization.noItemsFoundText);
    }

    if (sortByErrorMessage.isNotEmpty) {
      return Center(child: Text(sortByErrorMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.filterPageSortByText,
          style: FilterPageTextStyles.sectionNameTextStyle,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            context.read<FilterBloc>().add(ToggleSortByDropdownEvent());
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
                    selectedSortBy,
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
          ...sortBy.map(
            (sortByOption) => GestureDetector(
              onTap: () {
                context
                    .read<FilterBloc>()
                    .add(ChangeSortByEvent(sortByOption.name));
                context.read<FilterBloc>().add(ToggleSortByDropdownEvent());
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
                        sortByOption.name,
                        overflow: TextOverflow.ellipsis,
                        style: FilterPageTextStyles.valueTextStyle,
                      ),
                    ),
                    if (selectedSortBy == sortByOption.name)
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
