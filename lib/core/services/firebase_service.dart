import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../config.dart';
import '../utils/logging/logger_helper.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  factory FirebaseAuthService() => _instance;
  FirebaseAuthService._internal();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleObject = GoogleSignIn.instance;
    LoggerHelper.debug("Google Instance: $googleObject");

    googleObject.initialize(serverClientId: kServerClientId);
    LoggerHelper.debug("Google Initialized: $googleObject");

    if (!googleObject.supportsAuthenticate()) {
      LoggerHelper.debug("Google Sign-In is not supported on this platform.");
      throw FirebaseAuthException(
        code: 'ERROR_MISSING_GOOGLE_AUTH',
        message: 'Missing Google Auth in this platform',
      );
    }
    final googleUser = await googleObject.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final facebookObject = FacebookAuth.instance;
    LoggerHelper.debug("Facebook Initialized: ${facebookObject.runtimeType}");

    final loginResult = await facebookObject.login();
    LoggerHelper.debug("Facebook Login Result: $loginResult");

    if (loginResult.status != LoginStatus.success) return null;
    final credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signInWithPhone({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) {
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> verifySmsCode({
    required String verificationId,
    required String smsCode,
  }) {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() => _auth.signOut();
}
