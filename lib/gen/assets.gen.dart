/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/SFPRODISPLAYBOLD.OTF
  String get sfprodisplaybold => 'assets/fonts/SFPRODISPLAYBOLD.OTF';

  /// File path: assets/fonts/SFProText-Bold.ttf
  String get sFProTextBold => 'assets/fonts/SFProText-Bold.ttf';

  /// File path: assets/fonts/SFProText-Regular.ttf
  String get sFProTextRegular => 'assets/fonts/SFProText-Regular.ttf';

  /// List of all assets
  List<String> get values =>
      [sfprodisplaybold, sFProTextBold, sFProTextRegular];
}

class $AssetsGifsGen {
  const $AssetsGifsGen();

  /// File path: assets/gifs/GetStartedGirl.gif
  AssetGenImage get getStartedGirl =>
      const AssetGenImage('assets/gifs/GetStartedGirl.gif');

  /// List of all assets
  List<AssetGenImage> get values => [getStartedGirl];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/fashionSectionBg.jpg
  AssetGenImage get fashionSectionBg =>
      const AssetGenImage('assets/images/fashionSectionBg.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [fashionSectionBg];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsGifsGen gifs = $AssetsGifsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
