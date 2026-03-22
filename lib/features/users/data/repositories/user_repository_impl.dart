// data/repositories/user_repository_impl.dart
import 'dart:convert';
import 'package:user_app/core/network/api_service.dart';
import 'package:user_app/core/utils/cache_helper.dart';
import 'package:user_app/features/users/data/model/user_model.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final ApiService api;
  final CacheHelper cache;

  UserRepositoryImpl(this.api, this.cache);
  @override
Future<List<User>> getUsers(int page) async {
  try {
    
    final response = await api.getUsers(page);
final data = response['data'];

    print("API DATA: $data");

    cache.save(jsonEncode(data));

    return data
        .map<User>((e) => UserModel.fromJson(e))
        .toList();
  } catch (e) {
    print("ERROR: $e");

    final cached = await cache.get();

    if (cached != null) {
      final List data = jsonDecode(cached); // ✅ FIX

      return data
          .map<User>((e) => UserModel.fromJson(e))
          .toList();
    }

    throw Exception("No Internet & No Cache");
  }
}


}
