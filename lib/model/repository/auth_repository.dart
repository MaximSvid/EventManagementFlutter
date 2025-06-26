import 'dart:convert';

import 'package:event_management_flutter/model/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://localhost:8080'; 

  Future<User> register(String userName, String email, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'email': email,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<User> login(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}