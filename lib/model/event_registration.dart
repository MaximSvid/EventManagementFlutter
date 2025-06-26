// Modellklasse für eine Event-Registrierung in der Event-Management-Anwendung

import 'package:event_management_flutter/model/user.dart';
import 'package:event_management_flutter/model/event.dart';

/// Repräsentiert die Registrierung eines Benutzers für ein Event.
class EventRegistration {
  final int id; // Eindeutige ID der Registrierung
  final User user; // Der registrierte Benutzer
  final Event event; // Das zugehörige Event
  final DateTime registrationDate; // Datum der Registrierung

  EventRegistration({
    required this.id,
    required this.user,
    required this.event,
    required this.registrationDate,
  });

  /// Fabrikmethode zum Erstellen eines EventRegistration-Objekts aus JSON-Daten
  factory EventRegistration.fromJson(Map<String, dynamic> json) {
    return EventRegistration(
      id: json['id'],
      user: User.fromJson(json['user']),
      event: Event.fromJson(json['event']),
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
