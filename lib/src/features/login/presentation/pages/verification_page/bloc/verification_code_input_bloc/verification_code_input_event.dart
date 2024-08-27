part of 'verification_code_input_bloc.dart';

abstract class VerificationCodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CodeChanged extends VerificationCodeEvent {
  CodeChanged(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}
