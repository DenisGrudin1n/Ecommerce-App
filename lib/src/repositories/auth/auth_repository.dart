import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    required void Function(String message) verificationFailed,
    required void Function() verificationCompleted,
  });

  Future<void> resendCode({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String message) verificationFailed,
  });

  Future<UserCredential?> signInWithCredential(
    String verificationId,
    String smsCode,
  );
}
