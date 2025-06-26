// Bildschirm zur Anzeige des Benutzerprofils und der eigenen Events.

import 'package:event_management_flutter/viewModel/auth_view_model.dart';
import 'package:event_management_flutter/viewModel/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final eventViewModel = Provider.of<EventViewModel>(context);
    final user = authViewModel.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: user == null
          ? Center(child: Text('No user data'))
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Anzeige der Benutzerdaten
                  Text('Username: ${user.userName}', style: Theme.of(context).textTheme.headline6),
                  Text('Email: ${user.email}'),
                  Text('Role: ${user.role}'),
                  SizedBox(height: 16),
                  // Anzeige der eigenen Events
                  Text('My Events', style: Theme.of(context).textTheme.headline6),
                  Expanded(
                    child: ListView.builder(
                      itemCount: eventViewModel.events
                          .where((e) => e.organizer.id == user.id || e.registrations?.any((r) => r.user.id == user.id) == true)
                          .length,
                      itemBuilder: (context, index) {
                        final event = eventViewModel.events
                            .where((e) => e.organizer.id == user.id || e.registrations?.any((r) => r.user.id == user.id) == true)
                            .elementAt(index);
                        return EventCard(
                          event: event,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/event_detail',
                              arguments: event.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}