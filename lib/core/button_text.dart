import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonText({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<ButtonText> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<ButtonText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Text(
        widget.label,
        style: const TextStyle(
          color: ThemeColor.yellow,
        ),
      ),
    );
  }
}
