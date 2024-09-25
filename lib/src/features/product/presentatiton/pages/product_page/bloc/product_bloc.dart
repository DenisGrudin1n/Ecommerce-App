import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_event.dart';
import 'package:ecommerce_app/src/features/product/presentatiton/pages/product_page/bloc/product_state.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.storageRepository,
    required this.firestoreRepository,
  }) : super(const ProductState()) {
    on<LoadAppbarProductsEvent>(_onLoadAppbarProductsChanged);
    on<LoadAppbarSizesEvent>(_onLoadAppbarSizesChanged);
    on<LoadAppbarColorsPicsEvent>(_onLoadAppbarColorsPicsChanged);
    on<ChangeAppbarSizeEvent>(_onAppbarSizeChanged);
    on<ChangeColorPicEvent>(_onColorPicChanged);
    on<ToggleCommentHelpfulEvent>(_onToggleCommentHelpful);
    on<ToggleCartSizeEvent>(_onToggleCartSize);
    on<ToggleProductFavoriteEvent>(_onToggleProductFavorite);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
  }

  final StorageRepository storageRepository;
  final DatabaseRepository firestoreRepository;

  Future<void> _onLoadAppbarProductsChanged(
    LoadAppbarProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingAppbarProducts: true,
        appbarProductsErrorMessage: '',
      ),
    );

    try {
      final appbarProducts = await firestoreRepository.getAllAppbarProducts();

      emit(
        state.copyWith(
          appbarProducts: appbarProducts,
          isLoadingAppbarProducts: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appbarProductsErrorMessage: e.toString(),
          isLoadingAppbarProducts: false,
        ),
      );
    }
  }

  Future<void> _onLoadAppbarColorsPicsChanged(
    LoadAppbarColorsPicsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingAppbarColorsPics: true,
        appbarProductsColorsPicsErrorMessage: '',
      ),
    );

    try {
      final colorsPics = await firestoreRepository.getAllAppbarColorsPics();

      emit(
        state.copyWith(
          appbarProductsColorsPics: colorsPics,
          isLoadingAppbarColorsPics: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appbarProductsColorsPicsErrorMessage: e.toString(),
          isLoadingAppbarColorsPics: false,
        ),
      );
    }
  }

  void _onColorPicChanged(
    ChangeColorPicEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state.selectedAppbarProductsColorPics.contains(event.colorPic)) {
      emit(
        state.copyWith(
          selectedAppbarProductsColorPics: [],
          selectedImageUrl: '',
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedAppbarProductsColorPics: [event.colorPic],
          selectedImageUrl: event.selectedImageUrl,
        ),
      );
    }
  }

  Future<void> _onLoadAppbarSizesChanged(
    LoadAppbarSizesEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingAppbarProductsSizes: true,
        appbarProductsSizesErrorMessage: '',
      ),
    );

    try {
      final sizes = await firestoreRepository.getAllSizes();

      emit(
        state.copyWith(
          appbarProductsSizes: sizes,
          isLoadingAppbarProductsSizes: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appbarProductsSizesErrorMessage: e.toString(),
          isLoadingAppbarProductsSizes: false,
        ),
      );
    }
  }

  void _onAppbarSizeChanged(
    ChangeAppbarSizeEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state.selectedAppbarProductsSizes.contains(event.size)) {
      emit(state.copyWith(selectedAppbarProductsSizes: []));
    } else {
      emit(state.copyWith(selectedAppbarProductsSizes: [event.size]));
    }
  }

  void _onToggleCommentHelpful(
    ToggleCommentHelpfulEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(isCommentHelpful: !state.isCommentHelpful));
  }

  void _onToggleCartSize(
    ToggleCartSizeEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(isCartExpanded: !state.isCartExpanded));
  }

  void _onToggleProductFavorite(
    ToggleProductFavoriteEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(isProductFavorite: !state.isProductFavorite));
  }

  void _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state.counter > 1) {
      emit(state.copyWith(counter: state.counter - 1));
    }
  }
}
