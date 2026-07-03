import 'package:flutter/material.dart';

import 'visual_utils.dart';

class NetworkLinesVisual extends StatelessWidget {
  const NetworkLinesVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1700),
      painterBuilder: _NetworkLinesPainter.new,
    );
  }
}

class _NetworkLinesPainter extends CustomPainter {
  final double progress;

  const _NetworkLinesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(size.width * 0.16, size.height * 0.62),
      Offset(size.width * 0.31, size.height * 0.42),
      Offset(size.width * 0.48, size.height * 0.54),
      Offset(size.width * 0.63, size.height * 0.34),
      Offset(size.width * 0.82, size.height * 0.48),
    ];

    final linePaint = VisualPaints.stroke(visualGold, 3, alpha: 0.72);
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    drawPartialPath(canvas, path, linePaint, interval(progress, 0.15, 0.92));

    for (var i = 0; i < points.length; i++) {
      final appear = easeOut(interval(progress, i * 0.11, i * 0.11 + 0.36));
      canvas.drawCircle(
        points[i],
        8 * appear,
        VisualPaints.fill(visualGold, alpha: 0.88),
      );
      canvas.drawCircle(
        points[i],
        14 * appear,
        VisualPaints.stroke(visualWhite, 1.2, alpha: 0.22),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NetworkLinesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
