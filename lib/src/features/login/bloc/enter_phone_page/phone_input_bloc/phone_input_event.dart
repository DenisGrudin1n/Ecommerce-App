part of 'phone_input_bloc.dart';

abstract class PhoneInputEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends PhoneInputEvent {
  PhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class CountryChanged extends PhoneInputEvent {
  CountryChanged(this.country);
  final Country country;

  @override
  List<Object> get props => [country];
}
