// Wiederverwendbares Textfeld-Widget mit Label, Validator und optionalem Tastaturtyp.

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label; // Beschriftung des Textfelds
  final Function(String) onChanged; // Callback bei Änderung des Werts
  final String? Function(String?)? validator; // Optionaler Validator
  final TextInputType? keyboardType; // Optionaler Tastaturtyp

  CustomTextField({
    required this.label,
    required this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}