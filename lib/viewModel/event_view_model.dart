import 'package:flutter/material.dart';
import '../model/event.dart';
import '../repository/event_repository.dart';

/// ViewModel für die Verwaltung von Events.
/// Kümmert sich um das Laden, Erstellen und Registrieren von Events und hält den Zustand für die UI aktuell.
class EventViewModel extends ChangeNotifier {
  final EventRepository _repository =
      EventRepository(); // Instanz des EventRepositorys
  List<Event> events = []; // Liste aller geladenen Events
  Event? currentEvent; // Aktuell ausgewähltes Event
  bool isLoading = false; // Gibt an, ob ein Ladevorgang läuft
  String? errorMessage; // Speichert eine Fehlermeldung, falls vorhanden

  /// Lädt alle Events aus dem Backend.
  Future<void> fetchEvents() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      events = await _repository.getAllEvents();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Lädt ein Event anhand der ID.
  Future<void> fetchEventById(int id) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      currentEvent = await _repository.getEventById(id);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Erstellt ein neues Event und fügt es der Liste hinzu.
  Future<void> createEvent(Event event) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final newEvent = await _repository.createEvent(event);
      events.add(newEvent);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Registriert einen Benutzer für ein Event.
  Future<void> registerForEvent(int eventId, int userId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      await _repository.registerForEvent(eventId, userId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
