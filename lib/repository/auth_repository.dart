// Dieses Repository kümmert sich um die Authentifizierung und Benutzerverwaltung.
// Es stellt Methoden zur Registrierung und Anmeldung von Benutzern bereit.

import 'dart:convert';

import 'package:event_management_flutter/model/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  // Basis-URL für die Backend-API
  final String baseUrl = 'http://localhost:8080';

  // Registriert einen neuen Benutzer mit Benutzername, E-Mail und Rolle.
  // Gibt das erstellte User-Objekt zurück.
  Future<User> register(String userName, String email, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': userName, 'email': email, 'role': role}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // Meldet einen Benutzer mit der angegebenen E-Mail-Adresse an.
  // Gibt das User-Objekt zurück, wenn die Anmeldung erfolgreich ist.
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
