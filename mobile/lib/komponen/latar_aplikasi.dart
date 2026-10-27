// Penjelasan edukatif: Komponen UI yang dapat dipakai ulang agar tampilan dan interaksi antar layar tetap konsisten.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Keterangan kelas: AppBackground adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [_buildBackground(), child]);
  }

  Widget _buildBackground() {
    final assetPath = defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/images/Bg-ios.svg'
        : 'assets/images/Bg-android.svg';
    return SvgPicture.asset(
      assetPath,
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
    );
  }
}
