// Penjelasan edukatif: Komponen UI yang dapat dipakai ulang agar tampilan dan interaksi antar layar tetap konsisten.

import 'package:flutter/material.dart';

/// Keterangan kelas: AppLogo adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Logo mySBUM',
    );
  }
}
