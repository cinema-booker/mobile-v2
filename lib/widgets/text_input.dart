import 'package:flutter/material.dart';

import 'package:cinema_booker/widgets/base_input.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? defaultValue;
  final TextEditingController controller;
  final bool? isReadyOnly;
  final Function()? onTap;

  const TextInput({
    super.key,
    required this.hint,
    this.icon,
    this.keyboardType,
    this.defaultValue,
    required this.controller,
    this.isReadyOnly,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (defaultValue != null && controller.text.isEmpty) {
      controller.text = defaultValue!;
    }

    return BaseInput(
      controller: controller,
      hint: hint,
      icon: icon,
      keyboardType: keyboardType ?? TextInputType.text,
      isReadyOnly: isReadyOnly,
      onTap: onTap,
    );
  }
}
