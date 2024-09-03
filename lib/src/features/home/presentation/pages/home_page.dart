import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/widgets/home_bottom_navigation_bar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/catalogue_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/fashion_sale_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/featured_section.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_appbar.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/widgets/home_searchbar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                HomeAppbar(),
                HomeSearchBar(),
              ],
            ),
            SizedBox(height: 20),
            FashionSaleSection(),
            SizedBox(height: 20),
            CatalogueSection(),
            SizedBox(height: 20),
            FeaturedSection(),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}
