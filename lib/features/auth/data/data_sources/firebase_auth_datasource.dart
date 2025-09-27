import '../../../../core/services/firebase_service.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseService service;
  FirebaseAuthDataSource(this.service);
  Future<UserEntity?> signInUser(String email, String password) async {
    final cred = await service.signIn(email, password);
    final user = cred.user;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email!);
  }

  Future<UserEntity?> signUpUser(String email, String password) async {
    final cred = await service.signUp(email, password);
    final user = cred.user;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email!);
  }

  Future<void> signOut() async => service.signOut();

  Stream<UserEntity?> get userStream => service.authStateChanges.map((user) {
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email!);
  });
}
