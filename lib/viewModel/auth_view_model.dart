// ViewModel für die Authentifizierung. Verwaltet den aktuellen Benutzerzustand und die Kommunikation mit dem AuthRepository.

import 'package:event_management_flutter/model/user.dart'; // Importiert das User-Modell
import 'package:event_management_flutter/repository/auth_repository.dart'; // Importiert das Authentifizierungs-Repository
import 'package:flutter/material.dart'; // Importiert Flutter-spezifische Widgets und Klassen

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository =
      AuthRepository(); // Instanz des AuthRepositorys
  bool isLoading = false; // Gibt an, ob ein Ladevorgang läuft
  String? errorMessage; // Speichert eine Fehlermeldung, falls vorhanden
  User? currentUser; // Der aktuell angemeldete Benutzer

  // Registriert einen neuen Benutzer und aktualisiert den Zustand entsprechend
  Future<void> register(String userName, String email, String role) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      currentUser = await _repository.register(userName, email, role);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Meldet einen Benutzer an und aktualisiert den Zustand entsprechend
  Future<void> login(String email) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      currentUser = await _repository.login(email);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
