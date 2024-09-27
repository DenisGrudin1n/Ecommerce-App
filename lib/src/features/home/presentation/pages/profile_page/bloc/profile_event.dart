part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends ProfileEvent {
  const LogoutRequested({required this.onSuccess});
  final VoidCallback onSuccess;

  @override
  List<Object> get props => [onSuccess];
}
