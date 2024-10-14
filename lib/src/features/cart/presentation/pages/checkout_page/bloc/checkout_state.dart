part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    required this.selectedPaymentMethod,
    required this.showSuccessWindow,
    required this.isLoading,
  });

  final String selectedPaymentMethod;
  final bool showSuccessWindow;
  final bool isLoading;

  CheckoutState copyWith({
    String? selectedPaymentMethod,
    bool? showSuccessWindow,
    bool? isLoading,
  }) {
    return CheckoutState(
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      showSuccessWindow: showSuccessWindow ?? this.showSuccessWindow,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        selectedPaymentMethod,
        showSuccessWindow,
        isLoading,
      ];
}
