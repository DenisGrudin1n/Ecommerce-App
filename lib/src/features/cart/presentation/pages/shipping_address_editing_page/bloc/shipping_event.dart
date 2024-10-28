part of 'shipping_bloc.dart';

sealed class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object> get props => [];
}

class UpdateShippingInfoEvent extends ShippingEvent {
  const UpdateShippingInfoEvent({
    required this.fullName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
  });
  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;
}

class ValidateShippingInfoEvent extends ShippingEvent {}

class ResetNavigationEvent extends ShippingEvent {}

class ResetShippingInfoEvent extends ShippingEvent {}
