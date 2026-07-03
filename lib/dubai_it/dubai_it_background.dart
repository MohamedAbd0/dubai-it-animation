import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'dubai_it_theme.dart';

class DubaiItBackground extends StatefulWidget {
  final Widget child;

  const DubaiItBackground({super.key, required this.child});

  @override
  State<DubaiItBackground> createState() => _DubaiItBackgroundState();
}

class _DubaiItBackgroundState extends State<DubaiItBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _DubaiItBackgroundPainter(_controller.value),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _DubaiItBackgroundPainter extends CustomPainter {
  final double progress;

  const _DubaiItBackgroundPainter(this.progress);

  static const _particles = <Offset>[
    Offset(0.10, 0.18),
    Offset(0.22, 0.72),
    Offset(0.36, 0.30),
    Offset(0.48, 0.84),
    Offset(0.62, 0.20),
    Offset(0.74, 0.66),
    Offset(0.86, 0.36),
    Offset(0.92, 0.78),
    Offset(0.17, 0.44),
    Offset(0.57, 0.52),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          DubaiItColors.bgStart,
          DubaiItColors.bgMid,
          DubaiItColors.bgEnd,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final pulse = (math.sin(progress * math.pi * 2) + 1) / 2;
    final glowCenter = Offset(size.width * 0.72, size.height * 0.24);
    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              DubaiItColors.gold.withValues(alpha: 0.16 + pulse * 0.04),
              DubaiItColors.gold.withValues(alpha: 0.00),
            ],
          ).createShader(
            Rect.fromCircle(
              center: glowCenter,
              radius: size.shortestSide * 0.55,
            ),
          );
    canvas.drawCircle(glowCenter, size.shortestSide * 0.55, glowPaint);

    final linePaint = Paint()
      ..color = DubaiItColors.gold.withValues(alpha: 0.10)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 3; i++) {
      final y = size.height * (0.18 + i * 0.22);
      final shift = math.sin(progress * math.pi * 2 + i) * 18;
      final path = Path()
        ..moveTo(size.width * 0.08 + shift, y)
        ..quadraticBezierTo(
          size.width * 0.42,
          y + 26,
          size.width * 0.88 - shift,
          y + 4,
        );
      canvas.drawPath(path, linePaint);
    }

    final particlePaint = Paint()..color = Colors.white.withValues(alpha: 0.16);
    for (var i = 0; i < _particles.length; i++) {
      final base = _particles[i];
      final drift = math.sin(progress * math.pi * 2 + i * 0.8) * 8;
      final offset = Offset(
        base.dx * size.width + drift,
        base.dy * size.height - drift * 0.4,
      );
      final radius = 1.2 + (i % 3) * 0.45;
      canvas.drawCircle(offset, radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DubaiItBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
