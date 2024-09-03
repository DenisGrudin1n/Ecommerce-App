import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:equatable/equatable.dart';

part 'image_loader_event.dart';
part 'image_loader_state.dart';

class ImageLoaderBloc extends Bloc<ImageLoaderEvent, ImageLoaderState> {
  ImageLoaderBloc({required this.storageRepository})
      : super(ImageLoaderInitial()) {
    on<LoadImage>(_onLoadImage);
    on<LoadImages>(_onLoadImages);
  }
  final StorageRepository storageRepository;

  Future<void> _onLoadImage(
    LoadImage event,
    Emitter<ImageLoaderState> emit,
  ) async {
    final currentState = state;
    final updatedImageUrls = Map<String, String>.from(currentState.imageUrls);

    emit(ImageLoading(imageUrls: updatedImageUrls));

    try {
      final downloadURL =
          await storageRepository.getDownloadURL(event.imagePath);

      if (downloadURL != null) {
        updatedImageUrls[event.imagePath] = downloadURL;
        emit(ImageLoaded(imageUrls: updatedImageUrls));
      } else {
        emit(ImageLoadFailure(imageUrls: updatedImageUrls));
      }
    } catch (_) {
      emit(ImageLoadFailure(imageUrls: updatedImageUrls));
    }
  }

  Future<void> _onLoadImages(
    LoadImages event,
    Emitter<ImageLoaderState> emit,
  ) async {
    final currentState = state;
    final updatedImageUrls = Map<String, String>.from(currentState.imageUrls);

    emit(ImageLoading(imageUrls: updatedImageUrls));

    try {
      final futures = event.imagePaths.map((path) async {
        final downloadURL = await storageRepository.getDownloadURL(path);
        if (downloadURL != null) {
          updatedImageUrls[path] = downloadURL;
        }
      }).toList();

      await Future.wait(futures);

      emit(ImageLoaded(imageUrls: updatedImageUrls));
    } catch (_) {
      emit(ImageLoadFailure(imageUrls: updatedImageUrls));
    }
  }
}
