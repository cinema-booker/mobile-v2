import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const Screen({
    super.key,
    required this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
