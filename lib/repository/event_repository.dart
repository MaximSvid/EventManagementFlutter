import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/event.dart';
import '../model/event_registration.dart';


/// Repository-Klasse für die Verwaltung von Events.
/// Stellt Methoden zum Abrufen, Erstellen und Registrieren von Events bereit.
class EventRepository {
  final String baseUrl = 'http://localhost:8080/api'; // Basis-URL für die API

  /// Holt alle Events vom Backend.
  /// Gibt eine Liste von Event-Objekten zurück.
  Future<List<Event>> getAllEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events: ${response.body}');
    }
  }

  /// Holt ein einzelnes Event anhand der ID.
  /// Gibt das entsprechende Event-Objekt zurück.
  Future<Event> getEventById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$id'));
    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load event: ${response.body}');
    }
  }

  /// Erstellt ein neues Event im Backend.
  /// Gibt das erstellte Event-Objekt zurück.
  Future<Event> createEvent(Event event) async {
    final response = await http.post(
      Uri.parse('$baseUrl/events'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': event.title,
        'description': event.description,
        'date': event.date.toIso8601String(),
        'location': event.location,
        'maxParticipants': event.maxParticipants,
        'organizerId': event.organizer.id,
      }),
    );
    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create event: ${response.body}');
    }
  }

  /// Registriert einen Benutzer für ein Event.
  /// Gibt das EventRegistration-Objekt zurück.
  Future<EventRegistration> registerForEvent(int eventId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/events/$eventId/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId}),
    );
    if (response.statusCode == 200) {
      return EventRegistration.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register for event: ${response.body}');
    }
  }
}