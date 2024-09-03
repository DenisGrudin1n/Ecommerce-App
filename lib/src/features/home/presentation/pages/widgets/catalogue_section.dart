import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogueSection extends StatefulWidget {
  const CatalogueSection({super.key});

  @override
  State<CatalogueSection> createState() => _CatalogueSectionState();
}

class _CatalogueSectionState extends State<CatalogueSection> {
  final List<String> imagePaths = List.generate(
    8,
    (index) => 'catalogue/catalogue/item${index + 1}.jpg',
  );

  @override
  void initState() {
    super.initState();
    context.read<ImageLoaderBloc>().add(
          LoadImages(imagePaths: imagePaths),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageLoaderBloc, ImageLoaderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localization.homePageCatalogueText,
                    style: HomePageTextStyles.homePageCatalogueTextStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        context.localization.homePageSeeAllText,
                        style: HomePageTextStyles.homePageSeeAllTextStyle,
                      ),
                      AppIcons.seeAllIcon,
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 88,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagePaths.length,
                        itemBuilder: (context, index) {
                          final path = imagePaths[index];
                          final imageUrl = state.imageUrls[path];
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 16,
                            ),
                            child: Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(12),
                                image: imageUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: imageUrl == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : null,
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
