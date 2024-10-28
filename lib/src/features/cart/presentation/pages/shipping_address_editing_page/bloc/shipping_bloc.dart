import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  ShippingBloc() : super(const ShippingState()) {
    on<UpdateShippingInfoEvent>((event, emit) {
      emit(
        state.copyWith(
          fullName: event.fullName,
          address: event.address,
          city: event.city,
          postalCode: event.postalCode,
          phone: event.phone,
        ),
      );
    });

    on<ValidateShippingInfoEvent>((event, emit) {
      final hasError = state.fullName.isEmpty ||
          state.address.isEmpty ||
          state.city.isEmpty ||
          state.postalCode.isEmpty ||
          state.phone.isEmpty;

      emit(
        state.copyWith(
          showError: hasError,
        ),
      );

      if (!hasError) {
        _initialState = state;
        emit(state.copyWith(navigateToCheckout: true));
      }
    });

    on<ResetNavigationEvent>((event, emit) {
      emit(
        state.copyWith(
          navigateToCheckout: false,
        ),
      );
    });

    on<ResetShippingInfoEvent>((event, emit) {
      emit(_initialState);
    });
  }
  ShippingState _initialState = const ShippingState();
}
