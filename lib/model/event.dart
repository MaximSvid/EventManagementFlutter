// Modellklasse für ein Event in der Event-Management-Anwendung

import 'package:event_management_flutter/model/event_registration.dart';
import 'package:event_management_flutter/model/user.dart';

class Event {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final String? location;
  final int? maxParticipants;
  final User organizer;
  final List<EventRegistration>? registrations;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.location,
    this.maxParticipants,
    required this.organizer,
    this.registrations,
  });

  // Fabrikmethode zum Erstellen eines Event-Objekts aus JSON-Daten
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      maxParticipants: json['maxParticipants'],
      organizer: User.fromJson(json['organizer']),
      registrations:
          json['registrations'] != null
              ? (json['registrations'] as List)
                  .map((e) => EventRegistration.fromJson(e))
                  .toList()
              : null,
    );
  }
}
