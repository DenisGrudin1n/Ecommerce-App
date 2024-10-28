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
    final colorsMap = context.select<FilterBloc, Map<String, Color>>(
      (bloc) => bloc.state.colors,
    );
    final selectedColorsMap = context.select<FilterBloc, Map<String, Color>>(
      (bloc) => bloc.state.selectedColors,
    );
    final colorsErrorMessage = context.select<FilterBloc, String>(
      (bloc) => bloc.state.colorsErrorMessage,
    );

    if (colorsErrorMessage.isNotEmpty) {
      return Center(child: Text(colorsErrorMessage));
    }

    final colorsKeys = colorsMap.keys.toList();

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
          children: [
            for (int index = 0; index < colorsKeys.length; index++)
              GestureDetector(
                onTap: () {
                  final colorKey = colorsKeys[index];
                  context.read<FilterBloc>().add(ChangeColorEvent(colorKey));
                },
                child: index == 3
                    ? Row(
                        children: [
                          const SizedBox(width: 16),
                          _buildColorCircle(
                            colorsMap,
                            selectedColorsMap,
                            colorsKeys[index],
                          ),
                        ],
                      )
                    : _buildColorCircle(
                        colorsMap,
                        selectedColorsMap,
                        colorsKeys[index],
                      ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorCircle(
    Map<String, Color> colorsMap,
    Map<String, Color> selectedColorsMap,
    String colorKey,
  ) {
    final color = colorsMap[colorKey];
    final isSelected = selectedColorsMap.containsKey(colorKey);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 47,
          height: 47,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
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
    );
  }
}
