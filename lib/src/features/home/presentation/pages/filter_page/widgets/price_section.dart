import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:flutter/material.dart';
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
      text: filterBloc.state.minValue.toStringAsFixed(0),
    );
    maxPriceController = TextEditingController(
      text: filterBloc.state.maxValue.toStringAsFixed(0),
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
    return BlocConsumer<FilterBloc, FilterState>(
      listener: (context, state) {
        minPriceController.text = state.minValue.toStringAsFixed(0);
        maxPriceController.text = state.maxValue.toStringAsFixed(0);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price label
            Text(
              'Price',
              style: FilterPageTextStyles.priceTextStyle,
            ),

            // Applying custom theme for RangeSlider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.yellowColor,
                inactiveTrackColor: AppColors.lightGreyColor,
                thumbColor: Colors.white,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                ),
                overlayColor: Colors.black.withOpacity(0.1),
                overlayShape: const RoundSliderOverlayShape(),
                trackHeight: 4,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 12,
                ),
                rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                rangeTickMarkShape: const RoundRangeSliderTickMarkShape(),
              ),
              child: RangeSlider(
                values:
                    context.select((FilterBloc bloc) => bloc.state.rangeValues),
                max: 5000,
                divisions: 100,
                onChanged: (RangeValues values) {
                  context
                      .read<FilterBloc>()
                      .add(ChangeRangeSliderEvent(values));
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
                  onChanged: (newValue) {
                    final minValue = double.tryParse(newValue) ?? 0;
                    context
                        .read<FilterBloc>()
                        .add(ChangeMinValueEvent(minValue));
                  },
                ),

                const SizedBox(width: 16),

                // Maximum price input
                _buildPriceInputField(
                  controller: maxPriceController,
                  onChanged: (newValue) {
                    final maxValue = double.tryParse(newValue) ?? 5000;
                    context
                        .read<FilterBloc>()
                        .add(ChangeMaxValueEvent(maxValue));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to build price input fields for min/max
  Widget _buildPriceInputField({
    required TextEditingController controller,
    required void Function(String) onChanged,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        textAlign: TextAlign.center,
        onChanged: onChanged,
      ),
    );
  }
}
