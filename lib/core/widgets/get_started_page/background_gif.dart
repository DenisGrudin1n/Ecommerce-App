import 'package:ecommerce_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class GetStartedPageBackgroundGif extends StatelessWidget {
  const GetStartedPageBackgroundGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.gifs.getStartedGirl.image(
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }
}
