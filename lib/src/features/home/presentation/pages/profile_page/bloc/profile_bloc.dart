import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }
  final AuthRepository authRepository;

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoggingOut: true));
    try {
      await authRepository.signOut();
      emit(state.copyWith(isLoggingOut: false));
      event.onSuccess();
    } catch (e) {
      emit(
        state.copyWith(
          isLoggingOut: false,
          logoutErrorMessage: e.toString(),
        ),
      );
    }
  }
}
