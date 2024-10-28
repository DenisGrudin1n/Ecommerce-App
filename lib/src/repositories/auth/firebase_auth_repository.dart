import 'dart:developer';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  int? _forceResendingToken;

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    required void Function(String message) verificationFailed,
    required void Function() verificationCompleted,
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
          _forceResendingToken = forceResendingToken;
          codeSent(verificationId, forceResendingToken);
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: _forceResendingToken,
      );
    } catch (e) {
      log('Verification failed with exception: $e');
      verificationFailed(e.toString());
    }
  }

  @override
  Future<void> resendCode({
    required String phoneNumber,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String message) verificationFailed,
  }) async {
    if (_forceResendingToken != null) {
      log('Resending code to $phoneNumber '
          'with forceResendingToken $_forceResendingToken');
      await verifyPhoneNumber(
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

  @override
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

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
