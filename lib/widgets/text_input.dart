import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const TextInput({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: ThemeColor.brown100,
        hintText: hint,
      ),
      validator: (value) {
        return null;
      },
    );
  }
}
