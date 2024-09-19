import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/brand_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/categories_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/colors_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/filter_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/price_section.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(
        storageRepository: context.read<StorageRepository>(),
        firestoreRepository: context.read<DatabaseRepository>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const FilterAppbar(), // Fixed Appbar
            // Body
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 34,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PriceSection widget
                  const PriceSection(),

                  const SizedBox(height: 24),

                  // Categories
                  const CategoriesSection(),

                  const SizedBox(height: 24),

                  // Brand
                  const BrandSection(),

                  const SizedBox(height: 24),

                  // Colors
                  const ColorsSection(),

                  const SizedBox(height: 24),

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

                  const SizedBox(height: 24),

                  // Sort by
                  _buildDropdown(context, 'Sort by', 'Featured'),

                  // Adjust the spacing
                  const SizedBox(height: 32),

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
          ],
        ),
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
