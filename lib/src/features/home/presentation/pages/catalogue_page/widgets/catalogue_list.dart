import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/bloc/catalogue_state.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/catalogue_page/widgets/subcategory_window.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogueList extends StatefulWidget {
  const CatalogueList({super.key});

  @override
  State<CatalogueList> createState() => _CatalogueListState();
}

class _CatalogueListState extends State<CatalogueList> {
  @override
  void initState() {
    super.initState();
    context.read<CatalogueBloc>().add(LoadCatalogueEvent());
  }

  void _showSubcategoryWindow(String categoryName) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      barrierColor: AppColors.blackColor.withOpacity(0.75),
      builder: (context) {
        return BlocProvider(
          create: (context) => CatalogueBloc(
            storageRepository: context.read<StorageRepository>(),
            firestoreRepository: context.read<DatabaseRepository>(),
          ),
          child: SubcategoryWindow(categoryName: categoryName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogueBloc, CatalogueState>(
      builder: (context, state) {
        final isLoading = state.isLoadingCatalogue;
        final categories = state.catalogueCategories;
        final errorMessage = state.catalogueErrorMessage;

        if (isLoading) {
          return const CircularProgressIndicator();
        } else if (categories.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    _showSubcategoryWindow(category.name);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          category.name,
                          style: CataloguePageTextStyles.catalogueNameTextStyle,
                        ),
                        const Spacer(),
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(category.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (errorMessage.isNotEmpty) {
          return Text(errorMessage);
        } else {
          return Container();
        }
      },
    );
  }
}
