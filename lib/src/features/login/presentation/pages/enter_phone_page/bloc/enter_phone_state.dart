part of 'enter_phone_bloc.dart';

abstract class EnterPhoneState extends Equatable {
  @override
  List<Object> get props => [];
}

class EnterPhoneInitial extends EnterPhoneState {}

class EnterPhoneUpdated extends EnterPhoneState {
  EnterPhoneUpdated(this.phoneNumber, this.country);
  final String phoneNumber;
  final Country country;

  @override
  List<Object> get props => [phoneNumber, country];
}
