import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? defaultValue;

  const TextInput({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.defaultValue,
  });

  @override
  Widget build(BuildContext context) {
    if (defaultValue != null && controller.text.isEmpty) {
      controller.text = defaultValue!;
    }

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
