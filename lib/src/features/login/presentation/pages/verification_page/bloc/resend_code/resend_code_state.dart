part of 'resend_code_bloc.dart';

abstract class ResendCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResendCodeInitial extends ResendCodeState {}

class ResendCodeLoaded extends ResendCodeState {
  ResendCodeLoaded(this.verificationId);
  final String verificationId;

  @override
  List<Object> get props => [verificationId];
}
