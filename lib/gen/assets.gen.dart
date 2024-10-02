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

  /// File path: assets/fonts/SFPRODISPLAYMEDIUM.OTF
  String get sfprodisplaymedium => 'assets/fonts/SFPRODISPLAYMEDIUM.OTF';

  /// File path: assets/fonts/SFProText-Bold.ttf
  String get sFProTextBold => 'assets/fonts/SFProText-Bold.ttf';

  /// File path: assets/fonts/SFProText-Regular.ttf
  String get sFProTextRegular => 'assets/fonts/SFProText-Regular.ttf';

  /// List of all assets
  List<String> get values =>
      [sfprodisplaybold, sfprodisplaymedium, sFProTextBold, sFProTextRegular];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ProfilePic.jpg
  AssetGenImage get profilePic =>
      const AssetGenImage('assets/images/ProfilePic.jpg');

  /// File path: assets/images/item1.jpg
  AssetGenImage get item1 => const AssetGenImage('assets/images/item1.jpg');

  /// File path: assets/images/item2.jpg
  AssetGenImage get item2 => const AssetGenImage('assets/images/item2.jpg');

  /// File path: assets/images/item3.jpg
  AssetGenImage get item3 => const AssetGenImage('assets/images/item3.jpg');

  /// File path: assets/images/mastercard.png
  AssetGenImage get mastercard =>
      const AssetGenImage('assets/images/mastercard.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [profilePic, item1, item2, item3, mastercard];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
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
