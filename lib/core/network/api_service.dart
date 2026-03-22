// // // core/network/api_service.dart
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class ApiService {
// //   Future<Map<String, dynamic>> getUsers(int page) async {
// //     final response = await http
// //         .get(Uri.parse("https://api.github.com/users"));
// //         // .timeout(Duration(seconds: 10));

// //     if (response.statusCode == 200) {
// //         print(response.statusCode);
// //       return json.decode(response.body);
    
// //     } else {
// //       throw Exception("API Error");
// //     }
// //   }
// // }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   Future<Map<String, dynamic>> getUsers(int page) async {
//   final response = await http.get(
//     Uri.parse("https://reqres.in/api/users?page=$page&per_page=10"),
//     headers: {
//     "x-api-key": "reqres_15753ed4057c4680b9b2d84747e8b0ea", // 🔥 add this
//     },
//   );



//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception("API Error");
//   }
// }
// //   Future<List<dynamic>> getUsers(int since) async {
// //   final response = await http.get(
// //     Uri.parse("https://api.github.com/users?per_page=10&since=$since"),
// //   );

// //   if (response.statusCode == 200) {
// //     return json.decode(response.body);
// //   } else {
// //     throw Exception("API Error");
// //   }
// // }


//   Future<List<dynamic>> searchUsers(String query) async {
//   final response = await http.get(
//     Uri.parse("https://api.github.com/search/users?q=$query"),
//   );

//   if (response.statusCode == 200) {
//     final decoded = json.decode(response.body);
//     return decoded['items'];
//   } else {
//     throw Exception("Search failed");
//   }
// }
//   }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getUsers(int page) async {
    final url =
    "https://reqres.in/api/users?per_page=10;page=$page";
        // "https://reqres.in/api/users?page=$page&per_page=10";

    // ✅ PRINT URL
    print("GET USERS URL: $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "x-api-key": "reqres_15753ed4057c4680b9b2d84747e8b0ea",
      },
    );

    print("STATUS CODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // ✅ PRINT FULL RESPONSE
      print("RESPONSE BODY: $decoded");

      return decoded;
    } else {
      throw Exception("API Error");
    }
  }

}