import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page/bloc/get_started_event.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page/bloc/get_started_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';

class GetStartedBloc extends Bloc<GetStartedEvent, GetStartedState> {
  GetStartedBloc({
    required this.storageRepository,
    required this.firestoreRepository,
  }) : super(const GetStartedState()) {
    on<LoadGetStartedGifsEvent>(_onLoadGetStartedGifChanged);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;

  Future<void> _onLoadGetStartedGifChanged(
    LoadGetStartedGifsEvent event,
    Emitter<GetStartedState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingGifs: true,
        gifsErrorMessage: '',
      ),
    );

    try {
      final gifs = await firestoreRepository.getAllGetStartedGifs();
      emit(
        state.copyWith(
          gifs: gifs,
          isLoadingGifs: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          gifsErrorMessage: e.toString(),
          isLoadingGifs: false,
        ),
      );
    }
  }
}
