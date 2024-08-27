part of 'resend_code_bloc.dart';

abstract class ResendCodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResendCodeUpdated extends ResendCodeEvent {
  ResendCodeUpdated(this.verificationId);
  final String verificationId;

  @override
  List<Object> get props => [verificationId];
}
