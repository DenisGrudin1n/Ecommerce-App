import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/core/widgets/getStartedPage/background.dart';
import 'package:ecommerce_app/core/widgets/getStartedPage/background_gif.dart';
import 'package:ecommerce_app/core/widgets/getStartedPage/bottom_window.dart';
import 'package:ecommerce_app/core/widgets/getStartedPage/yellow_figure.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // Gif
          GetStartedPageBackgroundGif(),

          // Background
          GetStartedPageBackground(),

          // Yellow transparent figure
          GetStartedPageYellowFigure(),

          // Bottom window
          GetStartedPageBottomWindow(),
        ],
      ),
    );
  }
}
