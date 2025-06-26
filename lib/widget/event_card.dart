// Widget zur Darstellung einer Event-Karte in der Eventliste.

import 'package:flutter/material.dart';
import '../model/event.dart';

class EventCard extends StatelessWidget {
  final Event event; // Das Event, das angezeigt wird
  final VoidCallback onTap; // Callback bei Tap auf die Karte

  EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(event.title), // Titel des Events
        subtitle: Text(event.date.toString()), // Datum des Events
        onTap: onTap, // Aktion beim Antippen
      ),
    );
  }
}