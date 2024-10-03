part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class UpdatePaymentMethodEvent extends CheckoutEvent {
  const UpdatePaymentMethodEvent(this.paymentMethod);
  final String paymentMethod;

  @override
  List<Object> get props => [paymentMethod];
}

class ShowSuccessWindowEvent extends CheckoutEvent {}

class HideSuccessWindowEvent extends CheckoutEvent {}

class ShowLoadingEvent extends CheckoutEvent {}
