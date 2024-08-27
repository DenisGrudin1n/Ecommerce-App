part of 'enter_phone_bloc.dart';

abstract class EnterPhoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends EnterPhoneEvent {
  PhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class CountryChanged extends EnterPhoneEvent {
  CountryChanged(this.country);
  final Country country;

  @override
  List<Object> get props => [country];
}
