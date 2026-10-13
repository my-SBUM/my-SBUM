import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: _AppBackgroundPainter()),
        child,
      ],
    );
  }
}

class _AppBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFF9F9F9),
    );

    final blob = Path()
      ..moveTo(size.width * 0.64, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.19)
      ..cubicTo(
        size.width * 0.87,
        size.height * 0.22,
        size.width * 0.82,
        size.height * 0.10,
        size.width * 0.70,
        size.height * 0.12,
      )
      ..cubicTo(
        size.width * 0.57,
        size.height * 0.14,
        size.width * 0.52,
        size.height * 0.21,
        size.width * 0.40,
        size.height * 0.23,
      )
      ..lineTo(size.width * 0.64, 0)
      ..close();
    final blobPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xFFD8F2E4), Color(0xFFEAF7F0)],
      ).createShader(Offset.zero & size);
    canvas.drawPath(blob, blobPaint);

    final wave = Path()
      ..moveTo(size.width * 0.39, size.height * 0.23)
      ..cubicTo(
        size.width * 0.52,
        size.height * 0.21,
        size.width * 0.58,
        size.height * 0.14,
        size.width * 0.70,
        size.height * 0.13,
      )
      ..cubicTo(
        size.width * 0.83,
        size.height * 0.12,
        size.width * 0.88,
        size.height * 0.23,
        size.width,
        size.height * 0.19,
      )
      ..lineTo(size.width, size.height * 0.22)
      ..cubicTo(
        size.width * 0.86,
        size.height * 0.25,
        size.width * 0.81,
        size.height * 0.15,
        size.width * 0.70,
        size.height * 0.16,
      )
      ..cubicTo(
        size.width * 0.57,
        size.height * 0.17,
        size.width * 0.52,
        size.height * 0.24,
        size.width * 0.39,
        size.height * 0.26,
      )
      ..close();
    canvas.drawPath(wave, Paint()..color = const Color(0xCCFFFFFF));
  }

  @override
  bool shouldRepaint(covariant _AppBackgroundPainter oldDelegate) => false;
}
