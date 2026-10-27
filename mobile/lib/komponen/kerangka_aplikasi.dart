// Penjelasan edukatif: Komponen UI yang dapat dipakai ulang agar tampilan dan interaksi antar layar tetap konsisten.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/latar_aplikasi.dart';

/// Keterangan kelas: AppScaffold adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.showBackground = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: showBackground
              ? Colors.transparent
              : Color(0xFFF9F9F9),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        backgroundColor: showBackground
            ? Colors.transparent
            : Color(0xFFF9F9F9),
        extendBodyBehindAppBar: showBackground,
        appBar: appBar,
        body: showBackground
            ? AppBackground(child: body)
            : SafeArea(child: body),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
