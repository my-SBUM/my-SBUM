import 'package:flutter/material.dart';

class AppPageBackground extends StatelessWidget {
  const AppPageBackground({super.key, required this.child});

  final Widget child;

  static const Color color = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AppPageBackgroundLayer extends StatelessWidget {
  const AppPageBackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
