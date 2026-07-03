import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_utils.dart';

class ExceptionalResultsVisual extends StatelessWidget {
  const ExceptionalResultsVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1600),
      painterBuilder: _ExceptionalResultsPainter.new,
    );
  }
}

class _ExceptionalResultsPainter extends CustomPainter {
  final double progress;

  const _ExceptionalResultsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final arrowPaint = VisualPaints.stroke(visualGold, 5, alpha: 0.86);
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.44,
        size.height * 0.58,
        size.width * 0.58,
        size.height * 0.39,
      )
      ..quadraticBezierTo(
        size.width * 0.68,
        size.height * 0.25,
        size.width * 0.82,
        size.height * 0.24,
      );
    drawPartialPath(canvas, path, arrowPaint, interval(progress, 0, 0.75));

    final head = easeOut(interval(progress, 0.54, 0.9));
    final tip = Offset(size.width * 0.82, size.height * 0.24);
    if (head > 0) {
      final left = Offset.lerp(
        tip,
        Offset(size.width * 0.75, size.height * 0.22),
        head,
      )!;
      final bottom = Offset.lerp(
        tip,
        Offset(size.width * 0.80, size.height * 0.33),
        head,
      )!;
      canvas.drawLine(tip, left, arrowPaint);
      canvas.drawLine(tip, bottom, arrowPaint);
    }

    final ringProgress = interval(progress, 0.20, 1);
    final clockCenter = Offset(size.width * 0.27, size.height * 0.32);
    final radius = size.shortestSide * 0.13;
    canvas.drawArc(
      Rect.fromCircle(center: clockCenter, radius: radius),
      -math.pi / 2,
      math.pi * 2 * easeOut(ringProgress),
      false,
      VisualPaints.stroke(visualWhite, 2.2, alpha: 0.52),
    );
    canvas.drawLine(
      clockCenter,
      Offset(
        clockCenter.dx,
        clockCenter.dy - radius * 0.52 * easeOut(ringProgress),
      ),
      VisualPaints.stroke(visualWhite, 1.8, alpha: 0.62),
    );
    canvas.drawLine(
      clockCenter,
      Offset(
        clockCenter.dx + radius * 0.46 * easeOut(ringProgress),
        clockCenter.dy,
      ),
      VisualPaints.stroke(visualGold, 1.8, alpha: 0.78),
    );
  }

  @override
  bool shouldRepaint(covariant _ExceptionalResultsPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
