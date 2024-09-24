import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/brand_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/categories_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/colors_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/filter_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/price_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/results_button.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/size_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/widgets/sort_by_section.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
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
        firestoreRepository: context.read<DatabaseRepository>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: const [
            FilterAppbar(), // Fixed Appbar
            // Body
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 34,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PriceSection widget
                  PriceSection(),

                  SizedBox(height: 24),

                  // Categories
                  CategoriesSection(),

                  SizedBox(height: 24),

                  // Brand
                  BrandSection(),

                  SizedBox(height: 24),

                  // Colors
                  ColorsSection(),

                  SizedBox(height: 24),

                  // Sizes
                  SizeSection(),

                  SizedBox(height: 24),

                  // Sort by
                  SortBySection(),

                  SizedBox(height: 32),

                  // Results button
                  ResultsButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
