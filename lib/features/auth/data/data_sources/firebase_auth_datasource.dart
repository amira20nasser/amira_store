import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../../domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthDataSource {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;
  FirebaseAuthDataSource({
    required this.authService,
    required this.firestoreService,
  });
  Future<UserEntity?> signInUser(String email, String password) async {
    final cred = await authService.signIn(email, password);
    final user = cred.user;
    if (user == null) return null;

    final doc = await _getUserProfile(user.uid);
    if (!doc.exists) {
      LoggerHelper.debug("User document does not exist. Creating a new one.");
      await _createOrUpdateUser(
        user.uid,
        user.displayName ?? "default name",
        user.email!,
      );
    }

    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "default name",
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserProfile(String uid) {
    return firestoreService.getDocument(collectionPath: "users", docId: uid);
  }

  Future<UserEntity?> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final cred = await authService.signUp(email, password);
    final user = cred.user;
    if (user == null) return null;
    await _createOrUpdateUser(user.uid, username, email);
    await user.updateDisplayName(username);
    await user.reload();
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName!,
    );
  }

  Future<void> _createOrUpdateUser(String uid, String username, String email) {
    return firestoreService.setDocument(
      collectionPath: "users",
      docId: uid,
      data: {
        "username": username,
        "email": email,
        "createdAt": DateTime.now().toIso8601String(),
      },
      merge: true,
    );
  }

  Future<UserEntity?> signInWithGoogleUser() async {
    final userCredential = await authService.signInWithGoogle();
    final user = userCredential.user;
    if (user == null) return null;

    final doc = await _getUserProfile(user.uid);

    if (!doc.exists) {
      await _createOrUpdateUser(
        user.uid,
        user.displayName ?? "default name",
        user.email!,
      );
    }
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "default name",
    );
  }

  Future<UserEntity?> signInWithFacebookUser() async {
    final userCredential = await authService.signInWithFacebook();
    if (userCredential == null) return null;
    final user = userCredential.user;
    if (user == null) return null;

    final doc = await _getUserProfile(user.uid);

    if (!doc.exists) {
      await _createOrUpdateUser(
        user.uid,
        user.displayName ?? "default name",
        user.email!,
      );
    }
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "default name",
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
        );
      });
}
