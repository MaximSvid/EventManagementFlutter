// Authentifizierungsbildschirm für Login und Registrierung. 
// Verwaltet die Benutzereingaben und kommuniziert mit dem AuthViewModel.

import 'package:event_management_flutter/viewModel/auth_view_model.dart'; // Importiert das AuthViewModel für die Authentifizierung
import 'package:flutter/material.dart'; // Importiert Flutter-spezifische Widgets und Klassen
import 'package:provider/provider.dart'; // Importiert Provider für das State Management

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // Gibt an, ob sich der Benutzer im Login- oder Registrierungsmodus befindet
  final _formKey = GlobalKey<FormState>(); // Schlüssel für das Formular zur Validierung
  final _userNameController = TextEditingController(); // Controller für das Benutzernamenfeld
  final _emailController = TextEditingController(); // Controller für das E-Mail-Feld
  String? _selectedRole; // Speichert die ausgewählte Rolle

  @override
  void dispose() {
    // Gibt die Controller frei, wenn das Widget entfernt wird
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Wechselt zwischen Login- und Registrierungsmodus
  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      _formKey.currentState?.reset();
      _userNameController.clear();
      _emailController.clear();
      _selectedRole = null;
    });
  }

  // Sendet das Formular ab und ruft die entsprechende Methode im ViewModel auf
  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      
      if (_isLogin) {
        await authViewModel.login(_emailController.text);
      } else {
        await authViewModel.register(
          _userNameController.text,
          _emailController.text,
          _selectedRole!,
        );
      }

      // Bei erfolgreicher Authentifizierung zur Startseite navigieren
      if (authViewModel.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Baut das UI für den Authentifizierungsbildschirm
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(), // Stellt das AuthViewModel bereit
      child: Scaffold(
        appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Registration')),
        body: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isLogin)
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    if (!_isLogin)
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(labelText: 'Role'),
                        items: [
                          DropdownMenuItem(
                            value: 'ORGANIZER',
                            child: Text('ORGANIZER'),
                          ),
                          DropdownMenuItem(
                            value: 'PARTICIPANT',
                            child: Text('PARTICIPANT'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your role';
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 20),
                    if (viewModel.isLoading) CircularProgressIndicator(), // Zeigt einen Ladeindikator während der Authentifizierung
                    if (viewModel.errorMessage != null)
                      Text(viewModel.errorMessage!, style: TextStyle(color: Colors.red)), // Zeigt Fehlermeldungen an
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.isLoading ? null : () => _submit(context),
                      child: Text(_isLogin ? 'Login' : 'Register'),
                    ),
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(_isLogin
                          ? 'No account? Register'
                          : 'Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}