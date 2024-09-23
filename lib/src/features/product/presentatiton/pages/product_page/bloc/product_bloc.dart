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
    on<ChangeAppbarSizeEvent>(_onAppbarSizeChanged);
    on<LoadAppbarColorsPicsEvent>(_onLoadAppbarColorsPicsChanged);
    on<ChangeAppbarColorPicEvent>(_onAppbarColorPicChanged);
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

  void _onAppbarColorPicChanged(
    ChangeAppbarColorPicEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state.selectedAppbarProductsColorPics.contains(event.colorPic)) {
      emit(state.copyWith(selectedAppbarProductsColorPics: []));
    } else {
      emit(state.copyWith(selectedAppbarProductsColorPics: [event.colorPic]));
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
      ChangeAppbarSizeEvent event, Emitter<ProductState> emit) {
    if (state.selectedAppbarProductsSizes.contains(event.size)) {
      emit(state.copyWith(selectedAppbarProductsSizes: []));
    } else {
      emit(state.copyWith(selectedAppbarProductsSizes: [event.size]));
    }
  }
}
