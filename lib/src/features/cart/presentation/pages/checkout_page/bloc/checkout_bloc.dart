import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc()
      : super(
          const CheckoutState(
            showSuccessWindow: false,
            selectedPaymentMethod: 'DHL',
            isLoading: false,
          ),
        ) {
    on<UpdatePaymentMethodEvent>((event, emit) {
      emit(state.copyWith(selectedPaymentMethod: event.paymentMethod));
    });

    on<ShowLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
    });

    on<ShowSuccessWindowEvent>((event, emit) {
      emit(state.copyWith(isLoading: false, showSuccessWindow: true));
    });

    on<HideSuccessWindowEvent>((event, emit) {
      emit(state.copyWith(isLoading: false, showSuccessWindow: false));
    });
  }
}
