// core/utils/cache_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("users", data);
  }

  Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("users");
  }
}