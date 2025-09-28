import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  String _createdAt;
  UserModel({required super.uid, required super.email, required super.name})
    : _createdAt = DateTime.now().toIso8601String();
  factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['username'] ?? 'default name',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': name,
      "createdAt": _createdAt,
    };
  }
}
