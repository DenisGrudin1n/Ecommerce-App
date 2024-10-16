import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc({required this.authRepository})
      : super(VerificationCodeInitial()) {
    on<VerificationCodeChanged>(onVerificationCodeChanged);
    on<ResendCodeRequested>(onResendCodeRequested);
  }
  final AuthRepository authRepository;

  Future<void> onVerificationCodeChanged(
    VerificationCodeChanged event,
    Emitter<VerificationState> emit,
  ) async {
    emit(VerificationCodeUpdated(event.verificationId, event.code));

    if (event.code.length == 6) {
      emit(VerificationCodeLoading());

      await Future<void>.delayed(const Duration(seconds: 1));

      final authResult = await authRepository.signInWithCredential(
        event.verificationId,
        event.code,
      );

      if (authResult?.user != null) {
        emit(VerificationCodeVerified());
      } else {
        emit(VerificationCodeFailed());
      }
    }
  }

  Future<void> onResendCodeRequested(
    ResendCodeRequested event,
    Emitter<VerificationState> emit,
  ) async {
    await authRepository.resendCode(
      phoneNumber: event.phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        emit(ResendCodeLoaded(verificationId));
      },
      verificationFailed: (error) {
        emit(ResendCodeFailed(error));
      },
    );
  }
}
