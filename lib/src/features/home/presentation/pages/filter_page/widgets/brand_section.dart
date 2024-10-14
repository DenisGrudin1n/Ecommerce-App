import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/brand_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandSection extends StatefulWidget {
  const BrandSection({super.key});

  @override
  State<BrandSection> createState() => _BrandSectionState();
}

class _BrandSectionState extends State<BrandSection> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(LoadBrandsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final brands = context.select<FilterBloc, List<BrandModel>>(
      (bloc) => bloc.state.brands,
    );
    final isLoadingBrands = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isLoadingBrands,
    );
    final brandsErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.brandsErrorMessage,
    );
    final selectedBrands = context.select<FilterBloc, List<String>>(
      (bloc) => bloc.state.selectedBrands,
    );
    final isBrandDropdownOpen = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isBrandDropdownOpen,
    );

    if (isLoadingBrands) {
      return const Center(child: CircularProgressIndicator());
    }

    if (brands.isEmpty) {
      return Text(context.localization.noItemsFoundText);
    }

    if (brandsErrorMessage.isNotEmpty) {
      return Center(child: Text(brandsErrorMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.filterPageBrandsText,
          style: FilterPageTextStyles.sectionNameTextStyle,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            context.read<FilterBloc>().add(ToggleBrandDropdownEvent());
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
                    selectedBrands.join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: FilterPageTextStyles.valueTextStyle,
                  ),
                ),
                if (isBrandDropdownOpen)
                  AppIcons.filterPageCategoriesOpenedIcon
                else
                  AppIcons.filterPageCategoriesNotOpenedIcon,
              ],
            ),
          ),
        ),
        if (isBrandDropdownOpen) ...[
          const SizedBox(height: 8),
          for (final brand in brands)
            GestureDetector(
              onTap: () {
                context.read<FilterBloc>().add(ChangeBrandEvent(brand.name));
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
                        brand.name,
                        overflow: TextOverflow.ellipsis,
                        style: FilterPageTextStyles.valueTextStyle,
                      ),
                    ),
                    if (selectedBrands.contains(brand.name)) AppIcons.checkIcon,
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}
