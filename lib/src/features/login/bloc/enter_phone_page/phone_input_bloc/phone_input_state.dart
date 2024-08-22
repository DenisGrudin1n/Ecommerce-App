part of 'phone_input_bloc.dart';

abstract class PhoneInputState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneInputInitial extends PhoneInputState {}

class PhoneInputUpdated extends PhoneInputState {
  PhoneInputUpdated(this.phoneNumber, this.country);
  final String phoneNumber;
  final Country country;

  @override
  List<Object> get props => [phoneNumber, country];
}
