part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerificationCodeInitial extends VerificationState {}

class VerificationCodeVerified extends VerificationState {}

class VerificationCodeFailed extends VerificationState {}

class VerificationCodeUpdated extends VerificationState {
  VerificationCodeUpdated(this.verificationId, this.code);
  final String verificationId;
  final String code;

  @override
  List<Object> get props => [verificationId, code];
}

class ResendCodeLoaded extends VerificationState {
  ResendCodeLoaded(this.verificationId);
  final String verificationId;

  @override
  List<Object> get props => [verificationId];
}

class ResendCodeFailed extends VerificationState {
  ResendCodeFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class VerificationCodeLoading extends VerificationState {}
