import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/items_categories_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCategories extends StatefulWidget {
  const ItemsCategories({required this.onCategorySelected, super.key});
  final void Function(String) onCategorySelected;
  @override
  State<ItemsCategories> createState() => _ItemsCategoriesState();
}

class _ItemsCategoriesState extends State<ItemsCategories> {
  late String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(LoadItemsCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ItemsBloc, bool>(
      (bloc) => bloc.state.isLoadingItemsCategories,
    );
    final categories = context.select<ItemsBloc, List<ItemsCategoriesModel>>(
      (bloc) => bloc.state.itemsCategories,
    );
    final errorMessage = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.itemsCategoriesErrorMessage,
    );
    final selectedCategory = context.select<ItemsBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );

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
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  context
                      .read<ItemsBloc>()
                      .add(ChangeItemsCategoryEvent(category.name));
                  context
                      .read<FilterBloc>()
                      .add(ChangeCategoryEvent(category.name));
                  widget.onCategorySelected(category.name);
                },
                child: Container(
                  width: index == 0 ? 40 : 75,
                  height: 26,
                  decoration: BoxDecoration(
                    color: selectedCategory == category.name
                        ? AppColors.yellowColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: selectedCategory == category.name
                          ? ItemsPageTextStyles.allCategoryTextStyle
                          : ItemsPageTextStyles.categoriesTextStyle,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
