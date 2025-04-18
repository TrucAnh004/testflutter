import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/User.dart';

class UserAPIService {
  static final UserAPIService instance = UserAPIService._init();
  final String baseUrl = 'https://my-json-server.typicode.com/TrucAnh004/testflutter';

  UserAPIService._init();

  // Create - Thêm user mới
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode == 201) {
      return User.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  // Read - Lấy tất cả users
  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => User.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  // Read - Lấy user theo id
  Future<User?> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }

  // Update - Cập nhật user
  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  // Delete - Xoá user
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }

}
