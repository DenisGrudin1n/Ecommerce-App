import 'package:ecommerce_app/src/app/auth_bloc/auth_event.dart';
import 'package:ecommerce_app/src/app/auth_bloc/auth_state.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequestedEvent>(_onAuthCheckRequested);
    on<SignedInEvent>(_onSignedIn);
    on<SignedOutEvent>(_onSignedOut);
  }
  final AuthRepository authRepository;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final userOption = authRepository.getCurrentUser();
    if (userOption != null) {
      emit(Authenticated(userOption.uid));
    } else {
      emit(const Unauthenticated());
    }
  }

  void _onSignedIn(SignedInEvent event, Emitter<AuthState> emit) {
    final user = authRepository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user.uid));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onSignedOut(
    SignedOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signOut();
    emit(const Unauthenticated());
  }
}
