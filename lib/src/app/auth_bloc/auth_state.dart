import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated(this.userId);
  final String userId;

  Authenticated copyWith({String? userId}) {
    return Authenticated(userId ?? this.userId);
  }

  @override
  List<Object> get props => [userId];
}

class Unauthenticated extends AuthState {
  const Unauthenticated({this.errorMessage});
  final String? errorMessage;

  Unauthenticated copyWith({String? errorMessage}) {
    return Unauthenticated(errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [errorMessage ?? ''];
}
