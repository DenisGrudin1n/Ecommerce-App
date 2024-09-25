import 'package:ecommerce_app/src/features/home/models/size_model.dart';
import 'package:ecommerce_app/src/features/product/models/color_pic_model.dart';
import 'package:ecommerce_app/src/features/product/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  const ProductState({
    this.appbarProducts = const [],
    this.appbarProductsSizes = const [],
    this.appbarProductsColorsPics = const [],
    this.selectedAppbarProductsSizes = const [],
    this.selectedAppbarProductsColorPics = const [],
    this.selectedImageUrl = '',
    this.counter = 1,
    this.isLoadingAppbarProducts = false,
    this.isLoadingAppbarProductsSizes = false,
    this.isCommentHelpful = false,
    this.isCartExpanded = false,
    this.isProductFavorite = false,
    this.isLoadingAppbarColorsPics = false,
    this.appbarProductsErrorMessage = '',
    this.appbarProductsSizesErrorMessage = '',
    this.appbarProductsColorsPicsErrorMessage = '',
  });

  final List<AppbarProductModel> appbarProducts;
  final List<SizeModel> appbarProductsSizes;
  final List<AppbarColorPicModel> appbarProductsColorsPics;
  final List<String> selectedAppbarProductsSizes;
  final List<String> selectedAppbarProductsColorPics;
  final String selectedImageUrl;

  final int counter;

  final bool isLoadingAppbarProducts;
  final bool isLoadingAppbarColorsPics;
  final bool isLoadingAppbarProductsSizes;
  final bool isCommentHelpful;
  final bool isCartExpanded;
  final bool isProductFavorite;

  final String appbarProductsErrorMessage;
  final String appbarProductsSizesErrorMessage;
  final String appbarProductsColorsPicsErrorMessage;

  ProductState copyWith({
    List<AppbarProductModel>? appbarProducts,
    List<SizeModel>? appbarProductsSizes,
    List<AppbarColorPicModel>? appbarProductsColorsPics,
    List<String>? selectedAppbarProductsSizes,
    List<String>? selectedAppbarProductsColorPics,
    String? selectedImageUrl,
    int? counter,
    bool? isLoadingAppbarProducts,
    bool? isLoadingAppbarColorsPics,
    bool? isLoadingAppbarProductsSizes,
    bool? isCommentHelpful,
    bool? isCartExpanded,
    bool? isProductFavorite,
    String? appbarProductsErrorMessage,
    String? appbarProductsSizesErrorMessage,
    String? appbarProductsColorsPicsErrorMessage,
  }) {
    return ProductState(
      appbarProducts: appbarProducts ?? this.appbarProducts,
      appbarProductsSizes: appbarProductsSizes ?? this.appbarProductsSizes,
      appbarProductsColorsPics:
          appbarProductsColorsPics ?? this.appbarProductsColorsPics,
      selectedAppbarProductsSizes:
          selectedAppbarProductsSizes ?? this.selectedAppbarProductsSizes,
      selectedAppbarProductsColorPics: selectedAppbarProductsColorPics ??
          this.selectedAppbarProductsColorPics,
      selectedImageUrl: selectedImageUrl ?? this.selectedImageUrl,
      counter: counter ?? this.counter,
      isLoadingAppbarProducts:
          isLoadingAppbarProducts ?? this.isLoadingAppbarProducts,
      isLoadingAppbarColorsPics:
          isLoadingAppbarColorsPics ?? this.isLoadingAppbarColorsPics,
      isLoadingAppbarProductsSizes:
          isLoadingAppbarProductsSizes ?? this.isLoadingAppbarProductsSizes,
      isCartExpanded: isCartExpanded ?? this.isCartExpanded,
      isCommentHelpful: isCommentHelpful ?? this.isCommentHelpful,
      isProductFavorite: isProductFavorite ?? this.isProductFavorite,
      appbarProductsErrorMessage:
          appbarProductsErrorMessage ?? this.appbarProductsErrorMessage,
      appbarProductsSizesErrorMessage: appbarProductsSizesErrorMessage ??
          this.appbarProductsSizesErrorMessage,
      appbarProductsColorsPicsErrorMessage:
          appbarProductsColorsPicsErrorMessage ??
              this.appbarProductsColorsPicsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        appbarProducts,
        appbarProductsSizes,
        appbarProductsColorsPics,
        selectedAppbarProductsSizes,
        selectedAppbarProductsColorPics,
        selectedImageUrl,
        counter,
        isLoadingAppbarProducts,
        isLoadingAppbarColorsPics,
        isLoadingAppbarProductsSizes,
        isCommentHelpful,
        isCartExpanded,
        isProductFavorite,
        appbarProductsErrorMessage,
        appbarProductsSizesErrorMessage,
        appbarProductsColorsPicsErrorMessage,
      ];
}
