part of 'image_loader_bloc.dart';

abstract class ImageLoaderEvent extends Equatable {
  const ImageLoaderEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends ImageLoaderEvent {
  const LoadImage({required this.imagePath});
  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class LoadImages extends ImageLoaderEvent {
  const LoadImages({required this.imagePaths});
  final List<String> imagePaths;

  @override
  List<Object> get props => [imagePaths];
}
