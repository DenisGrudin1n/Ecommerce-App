import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedSection extends StatefulWidget {
  const FeaturedSection({super.key});

  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  final List<String> imagePaths = List.generate(
    4,
    (index) => 'home/featured/item${index + 1}.jpg',
  );

  final List<String> productNames = [
    'Saodimallsu Womens Turtleneck Oversized...',
    'Astylish Women Open Front Long Sleeve Ch...',
    'ECOWISH Womens Color Block Striped Draped K...',
    "Angashion Women's Sweaters Casual Long...",
  ];

  final List<String> prices = [r'$49', r'$89.99', r'$102.33', r'$132.98'];

  final List<String> oldPrices = [r'$99', '', '', ''];

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
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.6,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final path = imagePaths[index];
              final imageUrl = state.imageUrls[path];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Section
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: AppColors.greyColor,
                          ),
                          child: imageUrl == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        // Star Ratings
                        Row(
                          children: List.generate(
                            5,
                            (starIndex) => const Icon(
                              Icons.star,
                              color: AppColors.orangeColor,
                              size: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Product Name
                        Text(
                          productNames[index],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: HomePageTextStyles
                              .homePageFeaturedProductNameTextStyle,
                        ),
                        const SizedBox(height: 6),
                        // Price Section
                        if (oldPrices[index].isNotEmpty)
                          Row(
                            children: [
                              Text(
                                prices[index],
                                style: HomePageTextStyles
                                    .homePageFeaturedProductRedPriceTextStyle,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                oldPrices[index],
                                style: HomePageTextStyles
                                    .homePageFeaturedProductGreyPriceTextStyle,
                              ),
                            ],
                          )
                        else
                          Text(
                            prices[index],
                            style: HomePageTextStyles
                                .homePageFeaturedProductDarkPriceTextStyle,
                          ),
                      ],
                    ),
                  ),
                  // Favorite Icon Positioned
                  Positioned(
                    top: 152,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: oldPrices[index].isNotEmpty
                          ? const GradientIcon(
                              icon: Icons.favorite_border,
                              size: 20,
                              gradient: AppGradients.purpleGradient,
                              strokeWidth: 1,
                            )
                          : const Icon(
                              Icons.favorite,
                              size: 20,
                              color: AppColors.yellowColor,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 0,
                    child: Container(
                      height: 20,
                      width: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        gradient: AppGradients.orangeGradient,
                      ),
                      child: Center(
                        child: Text(
                          '-50%',
                          style: HomePageTextStyles
                              .homePageFeaturedDiscountPercentTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            childCount: imagePaths.length,
          ),
        );
      },
    );
  }
}
