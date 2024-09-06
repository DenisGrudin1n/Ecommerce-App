import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/home_page/bloc/home_state.dart';
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
    context.read<HomeBloc>().add(
          const LoadImageEvent(imagePath: 'home/fashion_sale/item1.jpg'),
        );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ImageLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is ImageLoadedState) {
          final imageUrl = state.imageUrls['home/fashion_sale/item1.jpg'];
          // Indicator Line Width = (Screen Width - Paddings Sum) / Lines Count
          final indictaorLineWidth =
              (MediaQuery.of(context).size.width - 64) / 5;
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
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
                                  style: HomePageTextStyles
                                      .homeFashionSaleTextStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      context.localization.homePageSeeMoreText,
                                      style: HomePageTextStyles
                                          .homeSeeMoreTextStyle,
                                    ),
                                    AppIcons.seeMoreIcon,
                                  ],
                                ),
                              ],
                            ),
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
                      count: 5,
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
              ],
            ),
          );
        } else if (state is ImageLoadFailureState) {
          return Text(context.localization.errorFailedToLoadImageText);
        } else {
          return Container();
        }
      },
    );
  }
}
