part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerificationCodeChanged extends VerificationEvent {
  VerificationCodeChanged(this.verificationId, this.code);
  final String verificationId;
  final String code;

  @override
  List<Object> get props => [verificationId, code];
}

class ResendCodeRequested extends VerificationEvent {
  ResendCodeRequested(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}
