import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.firestoreRepository}) : super(const CartState()) {
    on<UpdateCartEvent>(_onUpdateCartEvent);
    on<IncrementCartCounterEvent>(_onIncrementCartCounter);
    on<DecrementCartCounterEvent>(_onDecrementCartCounter);
    on<LoadCartProductsEvent>(_onLoadCartProducts);
    on<RemoveAllCartProductsEvent>(_onRemoveAllCartProducts);
    on<ClearCartEvent>(_onClearItems);
  }

  final DatabaseRepository firestoreRepository;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _onLoadCartProducts(
    LoadCartProductsEvent event,
    Emitter<CartState> emit,
  ) async {
    await emit.forEach<List<CartProduct>>(
      firestoreRepository.fetchCartProductsStream(userId),
      onData: (products) {
        return state.copyWith(products: products);
      },
      onError: (error, stackTrace) {
        log('Error loading cart products: $error');
        return state;
      },
    );
  }

  Future<void> _onUpdateCartEvent(
    UpdateCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      await _updateProductCounter(
        existingProductIndex,
        state.products[existingProductIndex].counter + event.counter,
        emit,
      );
    } else {
      final newProduct = CartProduct(
        productName: event.productName,
        productPrice: event.productPrice,
        counter: event.counter,
        imageUrl: event.imageUrl,
      );
      await firestoreRepository.addProductToCart(userId, newProduct);
    }
  }

  Future<void> _onIncrementCartCounter(
    IncrementCartCounterEvent event,
    Emitter<CartState> emit,
  ) async {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      await _updateProductCounter(
        existingProductIndex,
        state.products[existingProductIndex].counter + 1,
        emit,
      );
    }
  }

  Future<void> _onDecrementCartCounter(
    DecrementCartCounterEvent event,
    Emitter<CartState> emit,
  ) async {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      if (state.products[existingProductIndex].counter > 1) {
        await _updateProductCounter(
          existingProductIndex,
          state.products[existingProductIndex].counter - 1,
          emit,
        );
      }
    }
  }

  Future<void> _onRemoveAllCartProducts(
    RemoveAllCartProductsEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await firestoreRepository.removeAllProductsFromCart(userId);
      emit(state.copyWith(products: []));
    } catch (e) {
      log('Error clearing cart: $e');
    }
  }

  Future<void> _updateProductCounter(
    int index,
    int newCounter,
    Emitter<CartState> emit,
  ) async {
    final updatedProduct = state.products[index].copyWith(counter: newCounter);
    await firestoreRepository.addProductToCart(userId, updatedProduct);
    emit(
      state.copyWith(
        products: List<CartProduct>.from(state.products)
          ..[index] = updatedProduct,
      ),
    );
  }

  void _onClearItems(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(products: []));
  }
}
