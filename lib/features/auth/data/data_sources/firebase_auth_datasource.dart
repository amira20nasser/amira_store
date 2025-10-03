import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/firebase_service.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuthService authService;
  FirebaseAuthDataSource({required this.authService});

  Future<UserEntity?> signInUser(String email, String password) async {
    final cred = await authService.signIn(email, password);
    final user = cred.user;
    if (user == null) return null;

    return UserEntity(
      uid: user.uid,
      email: email,
      name: user.displayName ?? "Defualt Name",
      phone: user.phoneNumber,
    );
  }

  Future<UserEntity?> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final cred = await authService.signUp(email, password);
    final user = cred.user;
    if (user == null) return null;
    await _updateDisplayName(user, username);
    return UserEntity(
      uid: user.uid,
      email: email,
      name: username,
      phone: user.phoneNumber,
    );
  }

  Future<void> _updateDisplayName(User user, String displayName) async {
    await user.updateDisplayName(displayName);
    await user.reload();
  }

  Future<void> sendEmailVerification() async {
    final user = authService.currentUser;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        LoggerHelper.debug("The Email is already Verified");
      }
    } else {
      LoggerHelper.error("The User is null");
      throw Exception("The user doesn't logged in");
    }
  }

  Future<UserEntity?> signInWithGoogleUser() async {
    final userCredential = await authService.signInWithGoogle();
    final user = userCredential.user;
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "Defualt Name",
      phone: user.phoneNumber,
    );
  }

  Future<UserEntity?> signInWithFacebookUser() async {
    final userCredential = await authService.signInWithFacebook();
    if (userCredential == null) return null;
    final user = userCredential.user;
    if (user == null) return null;

    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "Defualt Name",
      phone: user.phoneNumber,
    );
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(FirebaseAuthException) verificationFailed,
    required void Function(String verificationId, int? resendToken) onCodeSent,
  }) async {
    await authService.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: onCodeSent,
      verificationFailed: verificationFailed,
      verificationCompleted: (PhoneAuthCredential credential) {
        LoggerHelper.debug(
          'Verification completed and You can sign in now/link with credential.',
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        LoggerHelper.debug(
          'Auto retrieval timeout. Verification ID: $verificationId',
        );
      },
    );
  }

  Future<void> verifyAndLinkSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    await authService.verifyAndLinkSmsCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<void> signInWithPhoneCredential({
    required String verificationId,
    required String smsCode,
  }) async {
    await authService.signInWithPhoneCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<void> signOut() async => authService.signOut();

  Stream<UserEntity?> get userStream =>
      authService.authStateChanges.map((user) {
        if (user == null) return null;
        return UserEntity(
          uid: user.uid,
          email: user.email!,
          name: user.displayName ?? "default name",
          phone: user.phoneNumber,
        );
      });
}
