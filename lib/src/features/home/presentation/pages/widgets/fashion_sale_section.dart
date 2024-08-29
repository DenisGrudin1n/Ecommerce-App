import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:ecommerce_app/core/theme/icons.dart';
import 'package:ecommerce_app/core/theme/text_styles.dart';
import 'package:ecommerce_app/src/features/home/repositories/firebase_storage_repository.dart';
import 'package:ecommerce_app/src/features/home/repositories/storage_repository.dart';
import 'package:flutter/material.dart';

class FashionSaleSection extends StatefulWidget {
  const FashionSaleSection({super.key});

  @override
  State<FashionSaleSection> createState() => _FashionSaleSectionState();
}

class _FashionSaleSectionState extends State<FashionSaleSection> {
  String? imageUrl;
  final StorageRepository storageRepository =
      StorageRepository(FirebaseStorageRepository());

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // Download image from Storage
    final downloadURL =
        await storageRepository.getDownloadURL('home/fashion_sale/item1.jpg');

    if (downloadURL != null) {
      setState(() {
        imageUrl = downloadURL;
      });

      // Add image URL to Collection
      await storageRepository.addImageURLToCollection(
        'home/fashion_sale',
        'imageUrl',
        downloadURL,
      );
    } else {
      print('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 95,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
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
  }
}
