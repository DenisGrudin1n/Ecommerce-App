import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<UpdateCartEvent>(_onUpdateCartEvent);
    on<IncrementCartCounterEvent>(_onIncrementCartCounter);
    on<DecrementCartCounterEvent>(_onDecrementCartCounter);
  }

  void _onUpdateCartEvent(UpdateCartEvent event, Emitter<CartState> emit) {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      final updatedProduct = state.products[existingProductIndex].copyWith(
        counter: state.products[existingProductIndex].counter + event.counter,
      );
      final updatedProducts = List<CartProduct>.from(state.products);
      updatedProducts[existingProductIndex] = updatedProduct;
      emit(state.copyWith(products: updatedProducts));
    } else {
      final newProduct = CartProduct(
        productName: event.productName,
        productPrice: event.productPrice,
        counter: event.counter,
        imageUrl: event.imageUrl,
      );
      emit(state.copyWith(products: [...state.products, newProduct]));
    }
  }

  void _onIncrementCartCounter(
    IncrementCartCounterEvent event,
    Emitter<CartState> emit,
  ) {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      final updatedProduct = state.products[existingProductIndex].copyWith(
        counter: state.products[existingProductIndex].counter + 1,
      );

      final updatedProducts = List<CartProduct>.from(state.products);
      updatedProducts[existingProductIndex] = updatedProduct;
      emit(state.copyWith(products: updatedProducts));
    }
  }

  void _onDecrementCartCounter(
    DecrementCartCounterEvent event,
    Emitter<CartState> emit,
  ) {
    final existingProductIndex = state.products
        .indexWhere((product) => product.imageUrl == event.imageUrl);

    if (existingProductIndex != -1) {
      if (state.products[existingProductIndex].counter > 1) {
        final updatedProduct = state.products[existingProductIndex].copyWith(
          counter: state.products[existingProductIndex].counter - 1,
        );

        final updatedProducts = List<CartProduct>.from(state.products);
        updatedProducts[existingProductIndex] = updatedProduct;
        emit(state.copyWith(products: updatedProducts));
      }
    }
  }
}
