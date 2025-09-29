import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/firestore_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class FirestoreDataSource {
  final FirestoreService firestoreService;
  FirestoreDataSource({required this.firestoreService});
  Future<void> createOrUpdateUser(User user) async {
    final UserEntity? userProfile = await getUserProfile(user.uid);
    UserModel? userModel;
    if (userProfile == null) {
      LoggerHelper.debug("Creating a new user....");
      userModel = UserModel(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? "default name",
        phoneNumber: user.phoneNumber,
      );
    } else {
      // exists, then update
      LoggerHelper.debug("Update The User.");
      userModel = UserModel.fromFirebase({
        'uid': user.uid,
        'email': user.email,
        'username': user.displayName,
        "phone": user.phoneNumber,
      });
    }
    await firestoreService.setDocument(
      collectionPath: "users",
      docId: userModel.uid,
      data: userModel.toMap(),
      merge: false,
    );
  }

  Future<UserEntity?> getUserProfile(String uid) async {
    final doc = await firestoreService.getDocument(
      collectionPath: "users",
      docId: uid,
    );
    if (!doc.exists || doc.data() == null) {
      LoggerHelper.debug("User document does not exist.");
      return null;
    }
    LoggerHelper.debug("User document exists.");

    return UserModel.fromFirebase(doc.data()!);
  }
}
