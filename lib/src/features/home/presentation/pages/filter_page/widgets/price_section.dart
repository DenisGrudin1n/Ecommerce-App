import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_state.dart'; // Для використання FilterState
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSection extends StatefulWidget {
  const PriceSection({super.key});

  @override
  State<PriceSection> createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;

  @override
  void initState() {
    super.initState();
    final filterBloc = context.read<FilterBloc>();
    minPriceController = TextEditingController(
      text: filterBloc.state.minValue == 0
          ? ''
          : '\$${filterBloc.state.minValue.toStringAsFixed(0)}',
    );
    maxPriceController = TextEditingController(
      text: filterBloc.state.maxValue == 9999
          ? ''
          : '\$${filterBloc.state.maxValue.toStringAsFixed(0)}',
    );
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterState>(
      listener: (context, state) {
        minPriceController.text = '\$${state.minValue.toStringAsFixed(0)}';
        maxPriceController.text = '\$${state.maxValue.toStringAsFixed(0)}';
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price label
          Text(
            context.localization.filterPagePriceText,
            style: FilterPageTextStyles.sectionNameTextStyle,
          ),

          // Applying custom theme for RangeSlider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.yellowColor,
              inactiveTrackColor: AppColors.lightGreyColor,
              thumbColor: AppColors.whiteColor,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
              ),
              overlayColor: AppColors.blackColor.withOpacity(0.1),
              overlayShape: const RoundSliderOverlayShape(),
              trackHeight: 4,
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 12,
              ),
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
              rangeTickMarkShape: const RoundRangeSliderTickMarkShape(),
            ),
            child: BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return RangeSlider(
                  values: state.rangeValues,
                  max: 9999,
                  divisions: 100,
                  onChanged: (RangeValues values) {
                    context
                        .read<FilterBloc>()
                        .add(ChangeRangeSliderEvent(values));
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Row with min/max text fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minimum price input
              _buildPriceInputField(
                controller: minPriceController,
                onEditingComplete: () {
                  final minValue = minPriceController.text.isEmpty
                      ? 0
                      : double.tryParse(
                            minPriceController.text.replaceAll(r'$', ''),
                          ) ??
                          0;
                  context
                      .read<FilterBloc>()
                      .add(ChangeMinValueEvent(minValue.toDouble()));
                },
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),

              // Maximum price input
              _buildPriceInputField(
                controller: maxPriceController,
                onEditingComplete: () {
                  final maxValue = maxPriceController.text.isEmpty
                      ? 9999
                      : double.tryParse(
                            maxPriceController.text.replaceAll(r'$', ''),
                          ) ??
                          9999;
                  context
                      .read<FilterBloc>()
                      .add(ChangeMaxValueEvent(maxValue.toDouble()));
                },
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to build price input fields for min/max
  Widget _buildPriceInputField({
    required TextEditingController controller,
    required VoidCallback onEditingComplete,
    required BorderRadius borderRadius,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: FilterPageTextStyles.valueTextStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.lightGreyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.lightGreyColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.lightGreyColor,
            ),
          ),
        ),
        textAlign: TextAlign.center,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: (value) {
          onEditingComplete();
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
      ),
    );
  }
}
