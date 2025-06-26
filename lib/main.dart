import 'package:event_management_flutter/view/auth_screen.dart';
import 'package:event_management_flutter/viewModel/auth_view_model.dart';
import 'package:event_management_flutter/viewModel/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/home_view.dart';
import 'view/event_detail_screen.dart';
import 'view/create_event_screen.dart';
import 'view/profile_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiProvider stellt beide ViewModels global zur Verfügung
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => EventViewModel()),
      ],
      child: MaterialApp(
        title: 'Event Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => AuthScreen(),
          '/home': (context) => HomeView(),
          '/event_detail': (context) => EventDetailScreen(),
          '/create_event': (context) => CreateEventScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}