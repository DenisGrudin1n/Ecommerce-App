import 'dart:developer';

import 'package:ecommerce_app/src/features/login/data/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._firebaseAuthRepository);
  final FirebaseAuthRepository _firebaseAuthRepository;
  int? _forceResendingToken;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    required void Function(String message) verificationFailed,
    required void Function() verificationCompleted,
  }) async {
    await _firebaseAuthRepository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _forceResendingToken = forceResendingToken;
        codeSent(verificationId, forceResendingToken);
      },
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationFailed: verificationFailed,
      verificationCompleted: verificationCompleted,
      forceResendingToken: _forceResendingToken,
    );
  }

  void resendCode({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String message) verificationFailed,
  }) {
    if (_forceResendingToken != null) {
      log('Resending code to $phoneNumber with forceResendingToken $_forceResendingToken');
      verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (verificationId) {},
        verificationFailed: verificationFailed,
        verificationCompleted: () {},
      );
    } else {
      log('Force resending token is null, cannot resend code.');
      verificationFailed('Force resending token is null');
    }
  }

  Future<UserCredential?> signInWithCredential(
    String verificationId,
    String smsCode,
  ) async {
    return _firebaseAuthRepository.signInWithCredential(
      verificationId,
      smsCode,
    );
  }
}
