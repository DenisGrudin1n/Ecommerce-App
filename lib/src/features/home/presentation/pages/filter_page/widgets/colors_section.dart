import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorsSection extends StatefulWidget {
  const ColorsSection({super.key});

  @override
  State<ColorsSection> createState() => _ColorsSectionState();
}

class _ColorsSectionState extends State<ColorsSection> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(LoadColorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.select<FilterBloc, List<Color>>(
      (bloc) => bloc.state.colors,
    );
    final selectedColors = context.select<FilterBloc, List<Color>>(
      (bloc) => bloc.state.selectedColors,
    );
    final colorsErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.colorsErrorMessage,
    );

    if (colorsErrorMessage.isNotEmpty) {
      return Center(child: Text(colorsErrorMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.filterPageColorsText,
          style: FilterPageTextStyles.sectionNameTextStyle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: colors.map((color) {
            if (color == AppColors.blueColor)
              return Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  _buildColorCircle(color, selectedColors),
                ],
              );
            return _buildColorCircle(color, selectedColors);
          }).toList(),
        ),
      ],
    );
  }

  // Widget for choosing colors
  Widget _buildColorCircle(Color color, List<Color> selectedColors) {
    return GestureDetector(
      onTap: () {
        context.read<FilterBloc>().add(ChangeColorEvent(color));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedColors.contains(color)
                    ? AppColors.yellowColor
                    : AppColors.transparentColor,
                width: 2,
              ),
            ),
          ),
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
