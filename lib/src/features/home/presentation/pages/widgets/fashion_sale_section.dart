import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/bloc/image_loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FashionSaleSection extends StatefulWidget {
  const FashionSaleSection({super.key});

  @override
  State<FashionSaleSection> createState() => _FashionSaleSectionState();
}

class _FashionSaleSectionState extends State<FashionSaleSection> {
  @override
  void initState() {
    super.initState();
    context.read<ImageLoaderBloc>().add(
          const LoadImage(imagePath: 'home/fashion_sale/item1.jpg'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageLoaderBloc, ImageLoaderState>(
      builder: (context, state) {
        if (state is ImageLoading) {
          return const CircularProgressIndicator();
        } else if (state is ImageLoaded) {
          final imageUrl = state.imageUrls['home/fashion_sale/item1.jpg'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.fashionSaleSectionGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        context.localization.homePageFashionSaleText,
                        style: HomePageTextStyles.homeFashionSaleTextStyle,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            context.localization.homePageSeeMoreText,
                            style: HomePageTextStyles.homeSeeMoreTextStyle,
                          ),
                          AppIcons.seeMoreIcon,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ImageLoadFailure) {
          return const Text('Failed to load image');
        } else {
          return Container();
        }
      },
    );
  }
}
