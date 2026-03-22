

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getUsers(int page) async {
    final url =
    "https://reqres.in/api/users?per_page=10;page=$page";


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

  
      print("RESPONSE BODY: $decoded");

      return decoded;
    } else {
      throw Exception("API Error");
    }
  }

}