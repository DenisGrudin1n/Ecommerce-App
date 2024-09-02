part of 'image_loader_bloc.dart';

abstract class ImageLoaderState extends Equatable {
  const ImageLoaderState({this.imageUrls = const {}});
  final Map<String, String> imageUrls;

  @override
  List<Object> get props => [imageUrls];
}

class ImageLoaderInitial extends ImageLoaderState {}

class ImageLoading extends ImageLoaderState {
  const ImageLoading({required super.imageUrls});
}

class ImageLoaded extends ImageLoaderState {
  const ImageLoaded({required super.imageUrls});
}

class ImageLoadFailure extends ImageLoaderState {
  const ImageLoadFailure({required super.imageUrls});
}
