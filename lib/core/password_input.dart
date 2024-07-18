import 'package:flutter/material.dart';

import 'package:cinema_booker/core/base_input.dart';

class PasswordInput extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final TextEditingController controller;

  const PasswordInput({
    super.key,
    required this.hint,
    this.icon,
    required this.controller,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: widget.controller,
      hint: widget.hint,
      keyboardType: TextInputType.visiblePassword,
      icon: widget.icon,
      isObscureText: _isObscureText,
      suffix: IconButton(
        icon: Icon(
          _isObscureText ? Icons.visibility : Icons.visibility_off,
        ),
        tooltip: 'Show password',
        onPressed: () {
          setState(() {
            _isObscureText = !_isObscureText;
          });
        },
      ),
    );
  }
}
