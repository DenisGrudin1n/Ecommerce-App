part of 'verification_code_input_bloc.dart';

abstract class VerificationCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerificationCodeInitial extends VerificationCodeState {}

class VerificationCodeUpdated extends VerificationCodeState {
  VerificationCodeUpdated(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}
