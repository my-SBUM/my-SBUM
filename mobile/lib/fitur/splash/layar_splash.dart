// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/komponen/latar_aplikasi.dart';

/// Keterangan kelas: SplashScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Keterangan kelas: _SplashScreenState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _navigationTimer = Timer(const Duration(seconds: 60), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = Curves.easeInOutCubic.transform(
                _controller.value,
              );
              return Column(
                children: [
                  const Spacer(flex: 3),
                  Opacity(
                    opacity: Curves.easeOut.transform(
                      (_controller.value * 1.35).clamp(0, 1),
                    ),
                    child: Transform.translate(
                      offset: Offset(0, 26 * (1 - progress)),
                      child: child,
                    ),
                  ),
                  const Spacer(flex: 3),
                  _LoadingIndicator(progress: progress),
                  const SizedBox(height: 32),
                ],
              );
            },
            child: const _BrandContent(),
          ),
        ),
      ),
    );
  }
}

/// Keterangan kelas: _BrandContent adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _BrandContent extends StatelessWidget {
  const _BrandContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 144,
          height: 144,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(235),
            borderRadius: BorderRadius.circular(34),
            boxShadow: const [
              BoxShadow(
                color: Color(0x24307D4D),
                blurRadius: 26,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              semanticLabel: 'Logo mySBUM',
            ),
          ),
        ),
        const SizedBox(height: 28),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'sans',
              color: Color(0xFF172335),
              height: 0.9,
            ),
            children: [
              TextSpan(
                text: 'my',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              TextSpan(
                text: 'SBUM',
                style: TextStyle(
                  color: Color(0xFF187C43),
                  fontSize: 54,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Ajuan ruangan dan peralatan dengan mudah',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF5D7082),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

/// Keterangan kelas: _LoadingIndicator adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 236,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: progress,
              backgroundColor: const Color(0xFFD8E7DE),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF21894B)),
            ),
          ),
        ),
        const SizedBox(height: 13),
        Text(
          progress < 0.8 ? 'Menyiapkan ruang terbaik' : 'Hampir siap',
          style: const TextStyle(
            color: Color(0xFF687C8D),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
