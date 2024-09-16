import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/filter_appbar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height excluding the app bar
          final availableHeight = constraints.maxHeight - kToolbarHeight;

          return Column(
            children: [
              const FilterAppbar(), // Fixed Appbar
              // Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: 34,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Slider for price range
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor,
                          height: 19 / 14,
                          letterSpacing: -0.15,
                        ),
                      ),
                      Slider(
                        value: 2500,
                        max: 5000,
                        divisions: 50,
                        activeColor: AppColors.yellowColor,
                        inactiveColor: AppColors.lightGreyColor,
                        onChanged: (value) {},
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(r'$0'),
                          Text(r'$5000'),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Categories
                      _buildDropdown(context, 'Categories', 'Dresses'),

                      const SizedBox(height: 8),

                      // Brand
                      _buildDropdown(
                        context,
                        'Brand',
                        'Lark & Ro, Astylish, ECOWISH, Angashion',
                      ),

                      const SizedBox(height: 8),

                      // Colors
                      const Text(
                        'Colors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildColorCircle(AppColors.darkColor),
                          _buildColorCircle(AppColors.redColor),
                          _buildColorCircle(AppColors.greenColor),
                          _buildColorCircle(AppColors.blueColor),
                          _buildColorCircle(AppColors.purpleColor),
                          _buildColorCircle(AppColors.lightYellowColor),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Sizes
                      const Text(
                        'Sizes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['XXS', 'XS', 'S', 'M', 'L', 'XL']
                            .map(_buildSizeButton)
                            .toList(),
                      ),

                      const SizedBox(height: 8),

                      // Sort by
                      _buildDropdown(context, 'Sort by', 'Featured'),

                      // Adjust the spacing
                      const SizedBox(height: 8),
                      if (availableHeight > 0) const Spacer(),

                      // Results button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellowColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Results (166)',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Drop down menu widget
  Widget _buildDropdown(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Logic for opening/closing menu
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.darkGreyColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget for choosing colors
  Widget _buildColorCircle(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
    );
  }

  // Widget for choosing sizes
  Widget _buildSizeButton(String size) {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          size,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
