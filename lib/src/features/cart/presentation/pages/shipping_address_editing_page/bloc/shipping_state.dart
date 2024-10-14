part of 'shipping_bloc.dart';

class ShippingState extends Equatable {
  const ShippingState({
    this.fullName = '',
    this.address = '',
    this.city = '',
    this.postalCode = '',
    this.phone = '',
    this.showError = false,
    this.navigateToCheckout = false,
  });

  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;
  final bool showError;
  final bool navigateToCheckout;

  ShippingState copyWith({
    String? fullName,
    String? address,
    String? city,
    String? postalCode,
    String? phone,
    bool? showError,
    bool? navigateToCheckout,
  }) {
    return ShippingState(
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
      showError: showError ?? this.showError,
      navigateToCheckout: navigateToCheckout ?? this.navigateToCheckout,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        address,
        city,
        postalCode,
        phone,
        showError,
        navigateToCheckout,
      ];
}
