import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcategoryWindow extends StatefulWidget {
  const SubcategoryWindow({
    required this.categoryName,
    super.key,
  });
  final String categoryName;
  @override
  State<SubcategoryWindow> createState() => _SubcategoryWindowState();
}

class _SubcategoryWindowState extends State<SubcategoryWindow> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadCatalogueSubcategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CatalogueSubcategoriesLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is CatalogueSubcategoriesLoadedState) {
          final subcategories = state.subcategories;
          return Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Center(
                    child: Text(
                      widget.categoryName,
                      style: CataloguePageTextStyles
                          .subcategoriesCategoryNameTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: subcategories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Text(
                          subcategories[index].name,
                          style: CataloguePageTextStyles.subcategoriesTextStyle,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        } else if (state is CatalogueSubcategoriesErrorState) {
          return Text(context.localization.errorFailedToLoadDataText);
        } else {
          return Container();
        }
      },
    );
  }
}
