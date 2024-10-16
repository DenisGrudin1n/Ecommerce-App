import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/opacities.dart';
import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page/widgets/get_started_window.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gif Image
          Assets.images.getStartedGif.image(
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
          ),

          // Background Color
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.backgroundColor
                .withOpacity(AppOpacities.lightOpacity),
          ),

          // Yellow Transparent Figure
          Positioned(
            top: MediaQuery.of(context).size.height * 0.57,
            left: MediaQuery.of(context).size.width,
            child: Transform(
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                width: 280,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.yellowColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(300),
                  ),
                ),
              ),
            ),
          ),

          // Get Started Window
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GetStartedWindow(),
          ),
        ],
      ),
    );
  }
}
