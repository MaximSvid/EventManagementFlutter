import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/event_view_model.dart';
import '../widget/event_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventViewModel>(context, listen: false).fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          if (authViewModel.currentUser?.role == 'ORGANIZER')
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/create_event'),
            ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => eventViewModel.fetchEvents(),
        child: eventViewModel.isLoading
            ? Center(child: CircularProgressIndicator())
            : eventViewModel.errorMessage != null
                ? Center(child: Text(eventViewModel.errorMessage!))
                : ListView.builder(
                    itemCount: eventViewModel.events.length,
                    itemBuilder: (context, index) {
                      final event = eventViewModel.events[index];
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
    );
  }
}