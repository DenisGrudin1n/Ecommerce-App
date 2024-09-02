import 'package:ecommerce_app/core/theme/colors.dart';
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
    4,
    (index) => 'home/catalogue/item${index + 1}.jpg',
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Catalogue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: imagePaths.map((path) {
                  final imageUrl = state.imageUrls[path];
                  return Container(
                    width: 70,
                    height: 70,
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
                        ? const Center(child: CircularProgressIndicator())
                        : null,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
