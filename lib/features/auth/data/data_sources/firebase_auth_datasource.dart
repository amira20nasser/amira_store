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
    return UserEntity(uid: user.uid, email: email, name: username);
  }

  Future<void> _updateDisplayName(User user, String displayName) async {
    await user.updateDisplayName(displayName);
    await user.reload();
  }

  Future<UserEntity?> signInWithGoogleUser() async {
    final userCredential = await authService.signInWithGoogle();
    final user = userCredential.user;
    if (user == null) return null;

    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "Defualt Name",
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
    );
  }

  // Future<void> verifyPhoneNumber({
  //   required String phoneNumber,
  //   required void Function(PhoneAuthCredential) onVerificationCompleted,
  //   required void Function(FirebaseAuthException) onVerificationFailed,
  //   required void Function(String verificationId, int? resendToken) onCodeSent,
  //   required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  // }) async {
  //   await authService.signInWithPhone(
  //     phoneNumber: phoneNumber,
  //     onVerificationCompleted: onVerificationCompleted,
  //     onVerificationFailed: onVerificationFailed,
  //     onCodeSent: onCodeSent,
  //     onCodeAutoRetrievalTimeout: (_) {},
  //   );
  // }

  // Future<UserEntity?> verifySmsCode({
  //   required String verificationId,
  //   required String smsCode,
  // }) async {
  //   final userCred = await authService.verifySmsCode(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   final user = userCred.user;
  //   if (user == null) return null;
  //   final doc = await _getUserProfile(user.uid);
  //   UserModel? userModel;

  //   if (!doc.exists) {
  //     LoggerHelper.debug("User document does not exist. Creating a new one.");
  //     userModel = UserModel(
  //       uid: user.uid,
  //       email: user.email!,
  //       name: user.displayName ?? "default name",
  //       phoneNumber: user.phoneNumber,
  //     );
  //     await _createOrUpdateUser(userModel);
  //   } else if (doc.data() != null) {
  //     LoggerHelper.debug("User document exists. Fetching data..");

  //     userModel = UserModel.fromFirebase(doc.data()!);
  //   }
  //   return userModel;
  // }

  Future<void> signOut() async => authService.signOut();

  Stream<UserEntity?> get userStream =>
      authService.authStateChanges.map((user) {
        if (user == null) return null;
        return UserEntity(
          uid: user.uid,
          email: user.email!,
          name: user.displayName ?? "default name",
        );
      });
}
