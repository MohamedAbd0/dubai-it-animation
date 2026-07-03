import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_utils.dart';

class DubaiItGlowVisual extends StatefulWidget {
  const DubaiItGlowVisual({super.key});

  @override
  State<DubaiItGlowVisual> createState() => _DubaiItGlowVisualState();
}

class _DubaiItGlowVisualState extends State<DubaiItGlowVisual>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _orbit;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1350),
    )..forward();
    _orbit = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _orbit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_entrance, _orbit]),
        builder: (context, _) {
          return CustomPaint(
            painter: _DubaiItGlowPainter(_entrance.value, _orbit.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _DubaiItGlowPainter extends CustomPainter {
  final double entrance;
  final double orbit;

  const _DubaiItGlowPainter(this.entrance, this.orbit);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final unit = size.shortestSide;
    final reveal = easeOut(entrance);
    final pulse = 0.5 + 0.5 * math.sin(orbit * math.pi * 2);
    final shimmer = 0.5 + 0.5 * math.sin(orbit * math.pi * 4);

    canvas.drawCircle(
      center,
      unit * (0.18 + reveal * 0.28 + pulse * 0.018),
      VisualPaints.glow(size, center, unit * 0.60, 0.28 * reveal),
    );

    final horizonReveal = easeOut(interval(entrance, 0.04, 0.56));
    final horizonPaint = VisualPaints.stroke(
      visualWhite,
      unit * 0.0035,
      alpha: 0.13 * horizonReveal,
    );
    for (var i = 0; i < 3; i++) {
      final y = center.dy + unit * (-0.30 + i * 0.30);
      final path = Path()
        ..moveTo(center.dx - unit * 0.72, y)
        ..quadraticBezierTo(
          center.dx,
          y + unit * (0.018 - i * 0.010),
          center.dx + unit * 0.72,
          y,
        );
      drawPartialPath(canvas, path, horizonPaint, horizonReveal);
    }

    final orbitalReveal = easeOut(interval(entrance, 0.10, 0.82));
    _drawRotatedArc(
      canvas,
      center,
      Rect.fromCenter(center: center, width: unit * 0.96, height: unit * 0.42),
      -0.15,
      orbit * math.pi * 2 - math.pi * 0.10,
      math.pi * (1.08 + shimmer * 0.16),
      VisualPaints.stroke(
        visualGold,
        unit * 0.011,
        alpha: 0.70 * orbitalReveal,
      ),
    );
    _drawRotatedArc(
      canvas,
      center,
      Rect.fromCenter(center: center, width: unit * 0.78, height: unit * 0.62),
      0.74,
      -orbit * math.pi * 2 + math.pi * 0.55,
      math.pi * 0.82,
      VisualPaints.stroke(
        visualGold,
        unit * 0.006,
        alpha: 0.34 * orbitalReveal,
      ),
    );
    _drawRotatedArc(
      canvas,
      center,
      Rect.fromCenter(center: center, width: unit * 0.55, height: unit * 0.86),
      -0.58,
      orbit * math.pi * 2 + math.pi * 0.18,
      math.pi * 0.52,
      VisualPaints.stroke(
        visualWhite,
        unit * 0.0045,
        alpha: 0.22 * orbitalReveal,
      ),
    );

    final markReveal = easeOut(interval(entrance, 0.20, 0.90));
    final markLift = unit * 0.020 * math.sin(orbit * math.pi * 2);
    final linePaint = VisualPaints.stroke(
      visualGold,
      unit * 0.024,
      alpha: 0.92,
    );
    final mark = Path()
      ..moveTo(center.dx - unit * 0.36, center.dy + unit * 0.16 + markLift)
      ..quadraticBezierTo(
        center.dx - unit * 0.24,
        center.dy - unit * 0.28 + markLift,
        center.dx + unit * 0.06,
        center.dy - unit * 0.22 + markLift,
      )
      ..cubicTo(
        center.dx + unit * 0.38,
        center.dy - unit * 0.15 + markLift,
        center.dx + unit * 0.42,
        center.dy + unit * 0.22 + markLift,
        center.dx + unit * 0.06,
        center.dy + unit * 0.24 + markLift,
      )
      ..quadraticBezierTo(
        center.dx - unit * 0.20,
        center.dy + unit * 0.25 + markLift,
        center.dx - unit * 0.20,
        center.dy + unit * 0.06 + markLift,
      );
    drawPartialPath(canvas, mark, linePaint, markReveal);

    final slashReveal = easeOut(interval(entrance, 0.38, 1));
    final slash = Path()
      ..moveTo(center.dx + unit * 0.05, center.dy + unit * 0.24 + markLift)
      ..lineTo(center.dx + unit * 0.22, center.dy - unit * 0.24 + markLift);
    drawPartialPath(
      canvas,
      slash,
      VisualPaints.stroke(visualWhite, unit * 0.013, alpha: 0.78),
      slashReveal,
    );

    for (var i = 0; i < 7; i++) {
      final nodeProgress = easeOut(interval(entrance, 0.18 + i * 0.05, 1));
      final angle = -math.pi * 0.86 + i * math.pi * 0.32 + orbit * math.pi * 2;
      final radiusX = unit * (0.36 + (i.isEven ? 0.03 : -0.02));
      final radiusY = unit * (0.18 + (i % 3) * 0.012);
      final nodeCenter = Offset(
        center.dx + math.cos(angle) * radiusX,
        center.dy + math.sin(angle) * radiusY,
      );
      final nodeSize = unit * (0.008 + (i % 2) * 0.004) * nodeProgress;
      canvas.drawCircle(
        nodeCenter,
        nodeSize,
        VisualPaints.fill(visualGold, alpha: 0.42 + nodeProgress * 0.40),
      );
    }

    final dotReveal = easeOut(interval(entrance, 0.56, 1));
    final dotPaint = VisualPaints.fill(visualWhite, alpha: 0.84 * dotReveal);
    canvas.drawCircle(center, unit * (0.018 + pulse * 0.007), dotPaint);
    canvas.drawPath(
      starPath(
        Offset(
          center.dx + unit * (0.30 + math.cos(orbit * math.pi * 2) * 0.018),
          center.dy - unit * (0.22 + math.sin(orbit * math.pi * 2) * 0.018),
        ),
        unit * (0.044 + pulse * 0.008) * dotReveal,
      ),
      VisualPaints.fill(visualGold, alpha: 0.82 * dotReveal),
    );
  }

  void _drawRotatedArc(
    Canvas canvas,
    Offset center,
    Rect rect,
    double rotation,
    double startAngle,
    double sweepAngle,
    Paint paint,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DubaiItGlowPainter oldDelegate) {
    return oldDelegate.entrance != entrance || oldDelegate.orbit != orbit;
  }
}
