part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoggingOut = false,
    this.logoutErrorMessage = '',
  });

  final bool isLoggingOut;
  final String logoutErrorMessage;

  ProfileState copyWith({
    bool? isLoggingOut,
    String? logoutErrorMessage,
  }) {
    return ProfileState(
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      logoutErrorMessage: logoutErrorMessage ?? this.logoutErrorMessage,
    );
  }

  @override
  List<Object> get props => [isLoggingOut, logoutErrorMessage];
}

class ProfileInitial extends ProfileState {}
