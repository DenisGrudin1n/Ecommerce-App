import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogueSection extends StatefulWidget {
  const CatalogueSection({super.key});

  @override
  State<CatalogueSection> createState() => _CatalogueSectionState();
}

class _CatalogueSectionState extends State<CatalogueSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeCatalogueEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state.isLoadingHomeCatalogue;
        final categories = state.homeCatalogueCategories;
        final errorMessage = state.homeCatalogueErrorMessage;

        if (isLoading) {
          return const CircularProgressIndicator();
        }

        if (categories.isEmpty) {
          return Text(context.localization.noItemsFoundText);
        }

        if (errorMessage.isNotEmpty) {
          return Text(errorMessage);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.router.push(const CatalogueRoute());
                    },
                    child: Text(
                      context.localization.homePageCatalogueText,
                      style: HomePageTextStyles.homePageCatalogueTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(const CatalogueRoute());
                    },
                    child: Row(
                      children: [
                        Text(
                          context.localization.homePageSeeAllText,
                          style: HomePageTextStyles.homePageSeeAllTextStyle,
                        ),
                        AppIcons.seeAllIcon,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 88,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              child: Container(
                                width: 88,
                                height: 88,
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(category.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    gradient:
                                        AppGradients.catalogueSectionGradient,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Align(
                                      child: Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: HomePageTextStyles
                                            .homePageCatalogueNameTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
