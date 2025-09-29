import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  late final String _createdAt;
  final String? phoneNumber;

  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required this.phoneNumber,
  }) : _createdAt = DateTime.now().toIso8601String();
  factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['username'] ?? 'default name',
      phoneNumber: data["phone"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': name,
      'phone': phoneNumber,
      "createdAt": _createdAt,
    };
  }
}
