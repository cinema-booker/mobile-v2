import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class BaseInput extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool? isObscureText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController? controller;

  const BaseInput({
    super.key,
    required this.hint,
    required this.keyboardType,
    this.isObscureText,
    this.icon,
    this.suffix,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: ThemeColor.white,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: ThemeColor.brown200,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColor.brown100,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColor.yellow,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: const TextStyle(
          color: ThemeColor.gray,
        ),
        hintText: hint,
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 8,
                ),
                child: Icon(
                  icon,
                  color: ThemeColor.gray,
                ),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
        ),
        suffixIcon: suffix,
      ),
      obscureText: isObscureText ?? false,
      keyboardType: keyboardType,
    );
  }
}
