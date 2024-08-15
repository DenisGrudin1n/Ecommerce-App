import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/widgets/get_started_page/background.dart';
import 'package:ecommerce_app/core/widgets/get_started_page/background_gif.dart';
import 'package:ecommerce_app/core/widgets/get_started_page/get_started_window.dart';
import 'package:ecommerce_app/core/widgets/get_started_page/yellow_figure.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Background Gif Image
          GetStartedPageBackgroundGif(),

          // Background Color
          GetStartedPageBackground(),

          // Yellow Transparent Figure

          Positioned(
            top: 420,
            left: 400,
            child: YellowFigure(),
          ),

          // Get Started Window
          Positioned(
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
