import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequestedEvent extends AuthEvent {}

class SignedInEvent extends AuthEvent {}

class SignedOutEvent extends AuthEvent {}
