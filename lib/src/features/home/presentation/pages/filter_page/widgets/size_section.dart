import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeSection extends StatefulWidget {
  const SizeSection({super.key});

  @override
  State<SizeSection> createState() => _SizeSectionState();
}

class _SizeSectionState extends State<SizeSection> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(LoadSizesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final sizes = context.select<FilterBloc, List<SizeModel>>(
      (bloc) => bloc.state.sizes,
    );
    final selectedSizes = context.select<FilterBloc, List<String>>(
      (bloc) => bloc.state.selectedSizes,
    );
    final isLoadingSizes = context.select<FilterBloc, bool>(
      (bloc) => bloc.state.isLoadingSizes,
    );
    final sizesErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.sizesErrorMessage,
    );

    if (isLoadingSizes) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sizes.isEmpty) {
      return Text(context.localization.noItemsFoundText);
    }

    if (sizesErrorMessage.isNotEmpty) {
      return Center(child: Text(sizesErrorMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.filterPageSizesText,
          style: FilterPageTextStyles.sectionNameTextStyle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            return GestureDetector(
              onTap: () {
                context.read<FilterBloc>().add(ChangeSizeEvent(size.name));
              },
              child: _buildSizeButton(size, selectedSizes),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget for choosing sizes
  Widget _buildSizeButton(SizeModel size, List<String> selectedSizes) {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
      decoration: BoxDecoration(
        color: selectedSizes.contains(size.name)
            ? AppColors.yellowColor
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          size.name,
          style: selectedSizes.contains(size.name)
              ? FilterPageTextStyles.selectedValueTextStyle
              : FilterPageTextStyles.valueTextStyle,
        ),
      ),
    );
  }
}
