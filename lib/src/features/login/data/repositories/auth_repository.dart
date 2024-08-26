import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? _verificationId;
  int? _forceResendingToken;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          _forceResendingToken = forceResendingToken;
          codeSent(verificationId, forceResendingToken);
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: forceResendingToken,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void resendCode({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(FirebaseAuthException) verificationFailed,
  }) {
    if (_verificationId != null) {
      log('Resending code to $phoneNumber with forceResendingToken $_forceResendingToken');
      verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {},
        verificationFailed: (e) {
          log('Verification failed during resend: ${e.message}');
          verificationFailed(e);
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          _forceResendingToken = forceResendingToken;
          log('New verification ID received: $verificationId');
          codeSent(verificationId, forceResendingToken);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        forceResendingToken: _forceResendingToken,
      );
    } else {
      log('Verification ID is null, cannot resend code.');
      verificationFailed(FirebaseAuthException(
        code: 'verification-id-null',
        message: 'Verification ID is null',
      ));
    }
  }

  Future<UserCredential> signInWithCredential(
      PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
