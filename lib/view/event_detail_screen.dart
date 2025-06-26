// Bildschirm zur Anzeige der Details eines Events und zur Registrierung für Teilnehmer.

import 'package:event_management_flutter/viewModel/auth_view_model.dart';
import 'package:event_management_flutter/viewModel/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventDetailScreen extends StatefulWidget {
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Holt die Event-ID aus den Routenargumenten und lädt das Event
    final eventId = ModalRoute.of(context)!.settings.arguments as int;
    Provider.of<EventViewModel>(context, listen: false).fetchEventById(eventId);
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final event = eventViewModel.currentEvent;

    return Scaffold(
      appBar: AppBar(title: Text('Event Details')),
      body: eventViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : event == null
              ? Center(child: Text('Event not found'))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 8),
                      Text('Description: ${event.description ?? 'No description'}'),
                      Text('Date: ${event.date.toString()}'),
                      Text('Location: ${event.location ?? 'No location'}'),
                      Text('Max Participants: ${event.maxParticipants ?? 'Unlimited'}'),
                      Text('Organizer: ${event.organizer.userName}'),
                      SizedBox(height: 16),
                      if (authViewModel.currentUser?.role == 'PARTICIPANT')
                        ElevatedButton(
                          onPressed: eventViewModel.isLoading
                              ? null
                              : () {
                                  eventViewModel.registerForEvent(
                                    event.id,
                                    authViewModel.currentUser!.id,
                                  );
                                },
                          child: Text('Register'),
                        ),
                    ],
                  ),
                ),
    );
  }
}