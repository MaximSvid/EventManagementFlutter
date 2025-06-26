import 'package:event_management_flutter/view/auth_screen.dart';
import 'package:event_management_flutter/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MaterialApp(
        title: 'Event Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => AuthScreen(),
          // '/home': (context) => HomeView(),
          // Добавим остальные маршруты позже
        },
      ),
    );
  }
}