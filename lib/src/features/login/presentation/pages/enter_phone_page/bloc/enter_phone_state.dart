part of 'enter_phone_bloc.dart';

abstract class EnterPhoneState extends Equatable {
  const EnterPhoneState({
    required this.phoneNumber,
    required this.country,
  });
  final String phoneNumber;
  final Country country;

  @override
  List<Object> get props => [phoneNumber, country];
}

class EnterPhoneUpdated extends EnterPhoneState {
  const EnterPhoneUpdated({
    required super.phoneNumber,
    required super.country,
  });
}
