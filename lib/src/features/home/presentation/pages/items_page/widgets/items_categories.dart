import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCategories extends StatefulWidget {
  const ItemsCategories({super.key});

  @override
  State<ItemsCategories> createState() => _ItemsCategoriesState();
}

class _ItemsCategoriesState extends State<ItemsCategories> {
  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(LoadItemsCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        final isLoading = state.isLoadingItemsCategories;
        final categories = state.itemsCategories;
        final errorMessage = state.itemsCategoriesErrorMessage;

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
                    child: Container(
                      width: 75,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Align(
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGreyColor,
                              height: 18 / 13,
                              letterSpacing: -0.08,
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
        );
      },
    );
  }
}
