import 'package:blog_app/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id, // we can write this as required super.id
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
