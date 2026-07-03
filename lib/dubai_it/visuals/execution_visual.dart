import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_utils.dart';

class ExecutionVisual extends StatelessWidget {
  const ExecutionVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1650),
      painterBuilder: _ExecutionPainter.new,
    );
  }
}

class _ExecutionPainter extends CustomPainter {
  final double progress;

  const _ExecutionPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final sparkCenter = Offset(size.width * 0.22, size.height * 0.58);
    final spark = easeOut(interval(progress, 0, 0.35));
    final sparkPaint = VisualPaints.stroke(visualGold, 2.2, alpha: 0.86);
    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final inner = Offset(
        sparkCenter.dx + math.cos(angle) * 8,
        sparkCenter.dy + math.sin(angle) * 8,
      );
      final outer = Offset(
        sparkCenter.dx + math.cos(angle) * (8 + 18 * spark),
        sparkCenter.dy + math.sin(angle) * (8 + 18 * spark),
      );
      canvas.drawLine(inner, outer, sparkPaint);
    }

    final climbPaint = VisualPaints.stroke(visualGold, 4.4, alpha: 0.84);
    final climb = Path()
      ..moveTo(size.width * 0.20, size.height * 0.72)
      ..lineTo(size.width * 0.36, size.height * 0.58)
      ..lineTo(size.width * 0.50, size.height * 0.66)
      ..lineTo(size.width * 0.70, size.height * 0.36)
      ..lineTo(size.width * 0.84, size.height * 0.48);
    drawPartialPath(canvas, climb, climbPaint, interval(progress, 0.20, 0.86));

    final peak = easeOut(interval(progress, 0.70, 1));
    if (peak > 0) {
      canvas.drawPath(
        starPath(Offset(size.width * 0.72, size.height * 0.32), 17 * peak),
        VisualPaints.fill(visualGold, alpha: 0.86),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ExecutionPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
