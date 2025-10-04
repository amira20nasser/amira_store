class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String? phone;
  final String? photoUrl;
  final bool emailVerified;
  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.photoUrl,
    this.emailVerified = false,
  });
}
