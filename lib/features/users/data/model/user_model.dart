

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatar,
  });
factory UserModel.fromJson(Map<String, dynamic> json) {
  String firstName = json['first_name'] ?? "";
  String lastName = json['last_name'] ?? "";

  return UserModel(
    id: json['id'] ?? 0,
    name: "$firstName $lastName".trim(),
    email: json['email'] ?? "No Email",

  
    avatar: "https://picsum.photos/200?random=${json['id']}",
  );
}



}