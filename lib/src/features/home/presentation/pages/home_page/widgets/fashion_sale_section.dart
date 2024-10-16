import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/models/fashion_sale_model.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FashionSaleSection extends StatefulWidget {
  const FashionSaleSection({super.key});

  @override
  State<FashionSaleSection> createState() => _FashionSaleSectionState();
}

class _FashionSaleSectionState extends State<FashionSaleSection> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<HomeBloc>().add(LoadFashionSaleImagesEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fashionSaleImages = context.select<HomeBloc, List<FashionSaleModel>>(
      (bloc) => bloc.state.fashionSaleImages,
    );
    final isLoading = context.select<HomeBloc, bool>(
      (bloc) => bloc.state.isLoadingFashionSale,
    );
    final errorMessage = context.select<HomeBloc, String>(
      (bloc) => bloc.state.fashionSaleErrorMessage,
    );

    if (isLoading) {
      return const CircularProgressIndicator();
    }

    if (errorMessage.isNotEmpty) {
      return Text(errorMessage);
    }

    // Indicator Line Width = (Screen Width - Paddings Sum) / Lines Count
    final indictaorLineWidth =
        (MediaQuery.of(context).size.width - 64) / fashionSaleImages.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 95,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: PageView.builder(
              controller: _pageController,
              itemCount: fashionSaleImages.length,
              itemBuilder: (context, index) {
                final image = fashionSaleImages[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(image.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppGradients.fashionSaleSectionGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: fashionSaleImages.length,
                effect: WormEffect(
                  activeDotColor: AppColors.whiteColor,
                  dotColor: AppColors.greyColor,
                  dotHeight: 2,
                  dotWidth: indictaorLineWidth,
                  spacing: 4,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
        ],
      ),
    );
  }
}
