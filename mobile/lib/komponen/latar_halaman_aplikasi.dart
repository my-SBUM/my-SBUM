// Penjelasan edukatif: Komponen UI yang dapat dipakai ulang agar tampilan dan interaksi antar layar tetap konsisten.

import 'package:flutter/material.dart';

/// Keterangan kelas: AppPageBackground adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppPageBackground extends StatelessWidget {
  const AppPageBackground({super.key, required this.child});

  final Widget child;

  static const Color color = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Keterangan kelas: AppPageBackgroundLayer adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppPageBackgroundLayer extends StatelessWidget {
  const AppPageBackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
