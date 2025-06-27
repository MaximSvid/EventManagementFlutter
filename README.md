## Event Management System - Mobile App
Eine Flutter-basierte mobile Anwendung für das Event Management System. Bietet eine intuitive Benutzeroberfläche für Event-Erstellung, -Verwaltung und -Teilnahme.

## 📋 Inhaltsverzeichnis

Überblick

Technologie-Stack

Projektstruktur

Installation & Setup

App-Architektur

Features

Screens

State Management

API Integration

Testing

Konfiguration

Troubleshooting

## 📖 Überblick
Die Flutter Mobile App bietet eine vollständige Event-Management-Lösung mit:

Benutzer-Authentifizierung - Registrierung und Login

Event-Übersicht - Liste aller verfügbaren Events

Event-Details - Detailansicht mit Anmeldemöglichkeit

Event-Erstellung - Neue Events erstellen (für Organisatoren)

Profil-Management - Eigene Events und Anmeldungen verwalten

## 🛠 Technologie-Stack

Flutter 3.16+ - Cross-platform UI Framework

Dart 3.0+ - Programming Language

Provider 6.0+ - State Management

HTTP 1.1+ - API Communication

Material Design 3 - UI Components

Flutter Localizations - Internationalization Support


## 🚀 Installation & Setup
Voraussetzungen

Flutter SDK 3.16+
Dart SDK 3.0+
Xcode (für iOS Development - nur macOS)
VS Code mit Flutter Extension 

Flutter Installation prüfen
bashflutter doctor -v
Projekt Setup

Dependencies installieren:
bashcd mobile-app
flutter pub get

Code Generation ausführen:
bashflutter packages pub run build_runner build

App starten:
bash# Android
flutter run

# iOS (nur macOS)
flutter run -d ios

# Specific Device
flutter run -d <device-id>


Backend-Verbindung konfigurieren
lib/utils/constants.dart:
dartclass AppConstants {
  // Development
  static const String baseUrl = 'http://localhost:8080/api';
  
  // iOS Simulator
  // static const String baseUrl = 'http://localhost:8080/api';
  
}
## 🏗 App-Architektur
MVVM Pattern mit Provider

## ✨ Features
✅ Implementierte Features
Authentication

 Benutzer-Registrierung mit Validierung
 Login mit Email/Passwort
 Automatische Session-Persistierung
 Logout-Funktionalität

Event Management

 Event-Liste mit Pull-to-Refresh
 Event-Details mit vollständigen Informationen
 Event-Erstellung für Organisatoren
 Event-Anmeldung für Teilnehmer
 Event-Suche und Filter

User Experience

 Loading States für alle API-Calls
 Error Handling mit benutzerfreundlichen Nachrichten
 Form-Validierung in Echtzeit
 Responsive Design für verschiedene Bildschirmgrößen
 Material Design 3 Komponenten

Performance

 Lazy Loading für Event-Listen
 Image Caching
 Optimierte Build-Größe
 Smooth Animations

## 📱 Screens
1. Authentication Screens
2. Event Screens
3. Event List Screen
4. Event Detail Screen
5. Profile Screen
