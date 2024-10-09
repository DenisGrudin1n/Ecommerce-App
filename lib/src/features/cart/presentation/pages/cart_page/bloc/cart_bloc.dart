import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.cartBox) : super(const CartState()) {
    on<UpdateCartEvent>(_onUpdateCartEvent);
    on<IncrementCartCounterEvent>(_onIncrementCartCounter);
    on<DecrementCartCounterEvent>(_onDecrementCartCounter);
    on<LoadCartProductsEvent>(_onLoadCartProducts);
  }

  final Box<CartProduct> cartBox;

  void _onLoadCartProducts(
    LoadCartProductsEvent event,
    Emitter<CartState> emit,
  ) {
    final products = cartBox.values.cast<CartProduct>().toList();
    emit(state.copyWith(products: products));
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
      await cartBox.add(newProduct);
      emit(
        state.copyWith(
          products: cartBox.values.cast<CartProduct>().toList(),
        ),
      );
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

  Future<void> _updateProductCounter(
    int index,
    int newCounter,
    Emitter<CartState> emit,
  ) async {
    final updatedProduct = state.products[index].copyWith(counter: newCounter);
    await cartBox.putAt(index, updatedProduct);
    emit(
      state.copyWith(
        products: List<CartProduct>.from(state.products)
          ..[index] = updatedProduct,
      ),
    );
  }
}
