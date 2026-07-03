import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_utils.dart';

class PromiseActionVisual extends StatelessWidget {
  const PromiseActionVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedVisualFrame(
      duration: const Duration(milliseconds: 1550),
      painterBuilder: _PromiseActionPainter.new,
    );
  }
}

class _PromiseActionPainter extends CustomPainter {
  final double progress;

  const _PromiseActionPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final unit = size.shortestSide;
    final center = Offset(size.width * 0.50, size.height * 0.50);
    final y1 = size.height * 0.36;
    final y2 = size.height * 0.64;
    final capsuleHeight = unit * 0.11;
    final capsuleRadius = Radius.circular(capsuleHeight / 2);
    final whiteLine = VisualPaints.stroke(
      visualWhite,
      unit * 0.008,
      alpha: 0.42,
    );
    final goldLine = VisualPaints.stroke(visualGold, unit * 0.016, alpha: 0.90);

    final promiseReveal = easeOut(interval(progress, 0, 0.34));
    final actionReveal = easeOut(interval(progress, 0.12, 0.48));
    final promiseRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.30, y1),
        width: unit * 0.58,
        height: capsuleHeight,
      ),
      capsuleRadius,
    );
    final actionRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.70, y2),
        width: unit * 0.58,
        height: capsuleHeight,
      ),
      capsuleRadius,
    );
    canvas.drawRRect(
      promiseRect,
      VisualPaints.fill(visualWhite, alpha: 0.06 * promiseReveal),
    );
    canvas.drawRRect(
      actionRect,
      VisualPaints.fill(visualWhite, alpha: 0.06 * actionReveal),
    );
    canvas.drawRRect(
      promiseRect,
      VisualPaints.stroke(
        visualWhite,
        unit * 0.006,
        alpha: 0.24 * promiseReveal,
      ),
    );
    canvas.drawRRect(
      actionRect,
      VisualPaints.stroke(visualGold, unit * 0.007, alpha: 0.48 * actionReveal),
    );

    final leftPath = Path()
      ..moveTo(size.width * 0.17, y1)
      ..lineTo(size.width * 0.43, y1);
    drawPartialPath(
      canvas,
      leftPath,
      whiteLine,
      interval(progress, 0.02, 0.36),
    );

    final bridgePath = Path()
      ..moveTo(size.width * 0.43, y1)
      ..quadraticBezierTo(
        center.dx - unit * 0.03,
        center.dy - unit * 0.04,
        center.dx,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx + unit * 0.06,
        center.dy + unit * 0.12,
        size.width * 0.58,
        y2,
      )
      ..lineTo(size.width * 0.77, y2);
    drawPartialPath(
      canvas,
      bridgePath,
      goldLine,
      interval(progress, 0.30, 0.80),
    );

    final motion = easeOut(interval(progress, 0.42, 0.86));
    for (var i = 0; i < 4; i++) {
      final t = (motion - i * 0.08).clamp(0.0, 1.0);
      if (t <= 0) continue;
      final angle = math.pi * (0.15 + i * 0.22);
      final dot = Offset(
        center.dx + math.cos(angle) * unit * 0.10 * t,
        center.dy + math.sin(angle) * unit * 0.08 * t,
      );
      canvas.drawCircle(
        dot,
        unit * 0.010 * (1 - t * 0.35),
        VisualPaints.fill(visualGold, alpha: 0.38 * (1 - i * 0.12)),
      );
    }

    final checkProgress = easeOut(interval(progress, 0.68, 1));
    if (checkProgress > 0) {
      final badgeCenter = Offset(size.width * 0.84, y2);
      canvas.drawCircle(
        badgeCenter,
        unit * 0.065 * checkProgress,
        VisualPaints.fill(visualGold, alpha: 0.12),
      );
      canvas.drawCircle(
        badgeCenter,
        unit * 0.060 * checkProgress,
        VisualPaints.stroke(visualGold, unit * 0.006, alpha: 0.52),
      );
      final check = Path()
        ..moveTo(badgeCenter.dx - unit * 0.030, badgeCenter.dy)
        ..lineTo(badgeCenter.dx - unit * 0.008, badgeCenter.dy + unit * 0.024)
        ..lineTo(badgeCenter.dx + unit * 0.040, badgeCenter.dy - unit * 0.035);
      drawPartialPath(
        canvas,
        check,
        VisualPaints.stroke(visualGold, unit * 0.014, alpha: 0.92),
        checkProgress,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PromiseActionPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
