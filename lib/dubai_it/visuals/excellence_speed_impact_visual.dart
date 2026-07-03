import 'package:flutter/material.dart';

import '../dubai_it_theme.dart';
import 'visual_utils.dart';

class ExcellenceSpeedImpactVisual extends StatelessWidget {
  const ExcellenceSpeedImpactVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1700),
      painterBuilder: _ExcellenceSpeedImpactPainter.new,
    );
  }
}

class _ExcellenceSpeedImpactPainter extends CustomPainter {
  final double progress;

  const _ExcellenceSpeedImpactPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.50, size.height * 0.50);
    final starts = [
      Offset(size.width * 0.25, size.height * 0.56),
      Offset(size.width * 0.50, size.height * 0.34),
      Offset(size.width * 0.75, size.height * 0.56),
    ];
    final labels = ['Excellence', 'Speed', 'Impact'];
    final merge = interval(progress, 0.42, 1);
    final appear = easeOut(interval(progress, 0, 0.38));
    final circlePaint = VisualPaints.stroke(visualGold, 2.5, alpha: 0.78);
    final fillPaint = VisualPaints.fill(visualGold, alpha: 0.12);

    for (var i = 0; i < starts.length; i++) {
      final point = lerpOffset(starts[i], center, merge);
      final radius = (size.shortestSide * 0.12) * appear * (1 - merge * 0.35);
      canvas.drawCircle(point, radius, fillPaint);
      canvas.drawCircle(point, radius, circlePaint);

      if (size.width > 420 && merge < 0.45) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: TextStyle(
              fontFamily: DubaiItTypography.fontFamily,
              fontFamilyFallback: DubaiItTypography.fallback,
              color: Colors.white.withValues(alpha: 0.58 * appear),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        )..layout(maxWidth: 110);
        textPainter.paint(
          canvas,
          Offset(point.dx - textPainter.width / 2, point.dy + radius + 8),
        );
      }
    }

    final finalPulse = easeOut(interval(progress, 0.72, 1));
    canvas.drawCircle(
      center,
      size.shortestSide * 0.08 * finalPulse,
      VisualPaints.fill(visualGold, alpha: 0.86),
    );
    canvas.drawCircle(
      center,
      size.shortestSide * 0.18 * finalPulse,
      VisualPaints.stroke(visualGold, 1.4, alpha: 0.38),
    );
  }

  @override
  bool shouldRepaint(covariant _ExcellenceSpeedImpactPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
