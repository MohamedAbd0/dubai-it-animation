import 'package:flutter/material.dart';

import 'visual_utils.dart';

class SpeedQualityVisual extends StatelessWidget {
  const SpeedQualityVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1500),
      painterBuilder: _SpeedQualityPainter.new,
    );
  }
}

class _SpeedQualityPainter extends CustomPainter {
  final double progress;

  const _SpeedQualityPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = VisualPaints.stroke(visualGold, 4.6, alpha: 0.86);
    final y = size.height * 0.52;
    final path = Path()
      ..moveTo(size.width * 0.16, y)
      ..cubicTo(
        size.width * 0.34,
        y - 18,
        size.width * 0.56,
        y + 18,
        size.width * 0.74,
        y,
      );
    drawPartialPath(canvas, path, linePaint, interval(progress, 0, 0.70));

    final streakPaint = VisualPaints.stroke(visualWhite, 1.6, alpha: 0.34);
    final streakProgress = easeOut(interval(progress, 0.10, 0.55));
    for (var i = 0; i < 3; i++) {
      final sx = size.width * (0.14 + i * 0.10);
      canvas.drawLine(
        Offset(sx - 34 * streakProgress, y + 28 + i * 4),
        Offset(sx - 8 * streakProgress, y + 28 + i * 4),
        streakPaint,
      );
    }

    final checkProgress = easeOut(interval(progress, 0.58, 1));
    if (checkProgress > 0) {
      final checkPath = Path()
        ..moveTo(size.width * 0.76, y - 2)
        ..lineTo(size.width * 0.81, y + 25)
        ..lineTo(size.width * 0.91, y - 32);
      drawPartialPath(canvas, checkPath, linePaint, checkProgress);
    }
  }

  @override
  bool shouldRepaint(covariant _SpeedQualityPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
