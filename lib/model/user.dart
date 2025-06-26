
// Diese Datei definiert das User-Modell für die Event-Management-Anwendung.
// Sie enthält die User-Klasse mit den Attributen id, userName, email und role.
class User {
  final int id;
  final String userName;
  final String email;
  final String role;

  User({required this.id, required this.userName, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
    );
  }
}