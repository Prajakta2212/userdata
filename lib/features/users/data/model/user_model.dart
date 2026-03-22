// // data/models/user_model.dart
// import '../../domain/entities/user.dart';

// class UserModel extends User {
//   UserModel({
//     required super.id,
//     required super.name,
//     required super.email,
//     required super.avatar,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       name: "${json['first_name']} ${json['last_name']}",
//       email: json['email'],
//       avatar: json['avatar'],
//     );
//   }
// }

// import '../../domain/entities/user.dart';

// class UserModel extends User {
//   UserModel({
//     required super.id,
//     required super.name,
//     required super.email,
//     required super.avatar,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] ?? 0,
//       name: json['first_name'] ?? "No Name",

//       // ❗ GitHub API doesn't give email here
//       email: json['email'],

//       // ✅ REAL avatar (fixes your issue)
//       avatar: json['avatar'] ?? "",
//     );
//   }
// }



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

    // ✅ Replace avatar with working image
    avatar: "https://picsum.photos/200?random=${json['id']}",
  );
}
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   // ✅ Fix avatar URL
  //   String avatar = json['avatar'] ?? "";
  //   // avatar = avatar.replaceAll("-image", "");

  //   // ✅ Create full name
  //   String firstName = json['first_name'] ?? "";
  //   String lastName = json['last_name'] ?? "";

  //   return UserModel(
  //     id: json['id'] ?? 0,

  //     // 🔥 FULL NAME
  //     name: "$firstName $lastName".trim(),

  //     // 🔥 EMAIL
  //     email: json['email'] ?? "No Email",

  //     // 🔥 AVATAR
  //     avatar: avatar,
  //   );
  // }



}