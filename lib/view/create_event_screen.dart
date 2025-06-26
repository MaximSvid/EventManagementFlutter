// Bildschirm zum Erstellen eines neuen Events. 
// Verwaltet die Eingaben des Benutzers und kommuniziert mit dem EventViewModel.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/event.dart';
import '../model/user.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/event_view_model.dart';
import '../widget/custom_text_field.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>(); // Schlüssel für das Formular zur Validierung
  String title = ''; // Titel des Events
  String? description; // Beschreibung des Events
  DateTime date = DateTime.now(); // Datum des Events
  String? location; // Ort des Events
  int? maxParticipants; // Maximale Teilnehmerzahl

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Eingabefeld für den Titel
              CustomTextField(
                label: 'Title',
                onChanged: (value) => title = value,
                validator: (value) => value!.isEmpty ? 'Enter title' : null,
              ),
              // Eingabefeld für die Beschreibung
              CustomTextField(
                label: 'Description',
                onChanged: (value) => description = value,
              ),
              // Eingabefeld für den Ort
              CustomTextField(
                label: 'Location',
                onChanged: (value) => location = value,
              ),
              // Eingabefeld für die maximale Teilnehmerzahl
              CustomTextField(
                label: 'Max Participants',
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    maxParticipants = int.tryParse(value) ?? null,
              ),
              // Button zum Erstellen des Events
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final event = Event(
                      id: 0, // Backend generiert die ID
                      title: title,
                      description: description,
                      date: date,
                      location: location,
                      maxParticipants: maxParticipants,
                      organizer: authViewModel.currentUser!,
                      registrations: [],
                    );
                    await eventViewModel.createEvent(event);
                    if (eventViewModel.errorMessage == null) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('Create Event'),
              ),
              // Anzeige von Fehlermeldungen
              if (eventViewModel.errorMessage != null)
                Text(eventViewModel.errorMessage!, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }