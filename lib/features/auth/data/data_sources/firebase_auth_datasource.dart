import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../../domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

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
    UserModel? userModel;

    if (!doc.exists) {
      LoggerHelper.debug("User document does not exist. Creating a new one.");
      userModel = UserModel(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? "default name",
      );
      await _createOrUpdateUser(userModel);
    } else if (doc.data() != null) {
      userModel = UserModel.fromFirebase(doc.data()!);
    }
    return userModel;
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
    final userModel = UserModel(
      uid: user.uid,
      email: user.email!,
      name: username,
    );
    await _createOrUpdateUser(userModel);
    await user.updateDisplayName(username);
    await user.reload();
    return userModel;
  }

  Future<void> _createOrUpdateUser(UserModel userModel) {
    return firestoreService.setDocument(
      collectionPath: "users",
      docId: userModel.uid,
      data: userModel.toMap(),
      merge: true,
    );
  }

  Future<UserEntity?> signInWithGoogleUser() async {
    final userCredential = await authService.signInWithGoogle();
    final user = userCredential.user;
    if (user == null) return null;

    final doc = await _getUserProfile(user.uid);
    UserModel? userModel;

    if (!doc.exists) {
      LoggerHelper.debug("User document does not exist. Creating a new one.");
      userModel = UserModel(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? "default name",
      );
      await _createOrUpdateUser(userModel);
    } else if (doc.data() != null) {
      LoggerHelper.debug("User document exists. Fetching data..");

      userModel = UserModel.fromFirebase(doc.data()!);
    }
    return userModel;
  }

  Future<UserEntity?> signInWithFacebookUser() async {
    final userCredential = await authService.signInWithFacebook();
    if (userCredential == null) return null;
    final user = userCredential.user;
    if (user == null) return null;

    final doc = await _getUserProfile(user.uid);
    UserModel? userModel;

    if (!doc.exists) {
      LoggerHelper.debug("User document does not exist. Creating a new one.");
      userModel = UserModel(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? "default name",
      );
      await _createOrUpdateUser(userModel);
    } else if (doc.data() != null) {
      LoggerHelper.debug("User document exists. Fetching data..");

      userModel = UserModel.fromFirebase(doc.data()!);
    }
    return userModel;
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
