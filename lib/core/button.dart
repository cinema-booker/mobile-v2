import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(ThemeColor.yellow),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 50),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: ThemeColor.brown300,
        ),
      ),
    );
  }
}
