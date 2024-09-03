import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    required void Function(String message) verificationFailed,
    required void Function() verificationCompleted,
    int? forceResendingToken,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          verificationCompleted();
        },
        verificationFailed: (e) {
          verificationFailed(e.message ?? 'Verification failed');
        },
        codeSent: (verificationId, forceResendingToken) {
          codeSent(verificationId, forceResendingToken);
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: forceResendingToken,
      );
    } catch (e) {
      log('Verification failed with exception: $e');
      verificationFailed(e.toString());
    }
  }

  Future<UserCredential?> signInWithCredential(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      log('Sign in failed with exception: $e');
      return null;
    }
  }
}
