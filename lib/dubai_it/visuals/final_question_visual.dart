import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'visual_utils.dart';

class FinalQuestionVisual extends StatefulWidget {
  const FinalQuestionVisual({super.key});

  @override
  State<FinalQuestionVisual> createState() => _FinalQuestionVisualState();
}

class _FinalQuestionVisualState extends State<FinalQuestionVisual>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _alive;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    _alive = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _alive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_entrance, _alive]),
        builder: (context, _) {
          return CustomPaint(
            painter: _FinalQuestionPainter(_entrance.value, _alive.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _FinalQuestionPainter extends CustomPainter {
  final double entrance;
  final double alive;

  const _FinalQuestionPainter(this.entrance, this.alive);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    final unit = math.min(size.height, size.width * 0.36);
    final left = Offset(size.width * 0.38, size.height * 0.50);
    final right = Offset(size.width * 0.62, size.height * 0.50);
    final ringReveal = easeOut(interval(entrance, 0, 0.42));
    final questionReveal = interval(entrance, 0.05, 0.50);
    final answerReveal = easeOut(interval(entrance, 0.46, 0.92));
    final sparkReveal = easeOut(interval(entrance, 0.68, 1));
    final pulse = 0.5 + 0.5 * math.sin(alive * math.pi * 2);
    final reversePulse = 0.5 + 0.5 * math.cos(alive * math.pi * 2);

    final connectorProgress = easeOut(interval(entrance, 0.38, 0.76));
    final connector = Path()
      ..moveTo(left.dx + unit * 0.24, size.height * 0.66)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * (0.74 + reversePulse * 0.015),
        right.dx - unit * 0.28,
        size.height * 0.66,
      );
    drawPartialPath(
      canvas,
      connector,
      VisualPaints.stroke(visualGold, unit * 0.005, alpha: 0.28),
      connectorProgress,
    );

    canvas.drawCircle(
      left,
      unit * (0.20 + pulse * 0.018) * ringReveal,
      VisualPaints.glow(size, left, unit * 0.32, 0.13 * ringReveal),
    );
    drawPartialPath(
      canvas,
      Path()..addOval(
        Rect.fromCircle(center: left, radius: unit * (0.25 + pulse * 0.006)),
      ),
      VisualPaints.stroke(visualWhite, unit * 0.005, alpha: 0.15),
      ringReveal,
    );

    _drawLivingArc(
      canvas,
      left,
      unit * 0.20,
      alive * math.pi * 2 - math.pi * 0.22,
      math.pi * 0.84,
      VisualPaints.stroke(
        visualGold,
        unit * 0.008,
        alpha: 0.48 * easeOut(interval(entrance, 0.16, 0.74)),
      ),
    );
    _drawLivingArc(
      canvas,
      left,
      unit * 0.26,
      -alive * math.pi * 2 + math.pi * 0.60,
      math.pi * 0.34,
      VisualPaints.stroke(visualWhite, unit * 0.004, alpha: 0.20 * ringReveal),
    );

    final questionPaint = VisualPaints.stroke(
      visualWhite,
      unit * 0.019,
      alpha: 0.70 * (1 - answerReveal * 0.18),
    );
    final question = Path()
      ..moveTo(left.dx - unit * 0.10, left.dy - unit * 0.11)
      ..cubicTo(
        left.dx - unit * 0.08,
        left.dy - unit * 0.23,
        left.dx + unit * 0.14,
        left.dy - unit * 0.21,
        left.dx + unit * 0.12,
        left.dy - unit * 0.07,
      )
      ..cubicTo(
        left.dx + unit * 0.10,
        left.dy + unit * 0.01,
        left.dx - unit * 0.02,
        left.dy + unit * 0.02,
        left.dx - unit * 0.01,
        left.dy + unit * 0.13,
      );
    drawPartialPath(canvas, question, questionPaint, questionReveal);

    final dot = easeOut(interval(entrance, 0.22, 0.56));
    canvas.drawCircle(
      Offset(left.dx, left.dy + unit * 0.20),
      unit * (0.017 + pulse * 0.004) * dot,
      VisualPaints.fill(visualWhite, alpha: 0.72 * (1 - answerReveal * 0.22)),
    );

    canvas.drawCircle(
      right,
      unit * (0.18 + reversePulse * 0.014) * answerReveal,
      VisualPaints.glow(size, right, unit * 0.30, 0.10 * answerReveal),
    );
    drawPartialPath(
      canvas,
      Path()..addOval(
        Rect.fromCircle(center: right, radius: unit * (0.22 + pulse * 0.004)),
      ),
      VisualPaints.stroke(visualGold, unit * 0.0045, alpha: 0.17),
      answerReveal,
    );

    final arrowPaint = VisualPaints.stroke(
      visualGold,
      unit * 0.016,
      alpha: 0.92,
    );
    final launch = Path()
      ..moveTo(right.dx - unit * 0.20, right.dy + unit * 0.13)
      ..quadraticBezierTo(
        right.dx - unit * 0.07,
        right.dy + unit * 0.03,
        right.dx + unit * 0.10,
        right.dy - unit * 0.13,
      )
      ..quadraticBezierTo(
        right.dx + unit * 0.17,
        right.dy - unit * 0.20,
        right.dx + unit * 0.24,
        right.dy - unit * 0.18,
      );
    drawPartialPath(canvas, launch, arrowPaint, answerReveal);
    if (answerReveal > 0.48) {
      final tip = Offset(right.dx + unit * 0.24, right.dy - unit * 0.18);
      final tipProgress = easeOut(interval(answerReveal, 0.48, 1));
      canvas.drawLine(
        tip,
        Offset(tip.dx - unit * 0.10 * tipProgress, tip.dy + unit * 0.005),
        arrowPaint,
      );
      canvas.drawLine(
        tip,
        Offset(tip.dx - unit * 0.008, tip.dy + unit * 0.10 * tipProgress),
        arrowPaint,
      );
    }

    final baseY = right.dy + unit * (0.25 + reversePulse * 0.010);
    final platformProgress = easeOut(interval(entrance, 0.54, 0.94));
    final platform = Path()
      ..moveTo(right.dx - unit * 0.26, baseY)
      ..lineTo(right.dx + unit * 0.26, baseY);
    drawPartialPath(
      canvas,
      platform,
      VisualPaints.stroke(visualWhite, unit * 0.007, alpha: 0.26),
      platformProgress,
    );
    if (answerReveal > 0) {
      final challenge = Path()
        ..moveTo(right.dx - unit * 0.22, right.dy + unit * 0.08)
        ..quadraticBezierTo(
          right.dx,
          right.dy + unit * 0.19,
          right.dx + unit * 0.22,
          right.dy + unit * 0.04,
        );
      drawPartialPath(
        canvas,
        challenge,
        VisualPaints.stroke(
          visualGold,
          unit * 0.005,
          alpha: 0.24 * answerReveal,
        ),
        (answerReveal + pulse * 0.08).clamp(0.0, 1.0),
      );
    }

    if (sparkReveal > 0) {
      canvas.drawPath(
        starPath(
          Offset(
            right.dx + unit * (0.24 + math.cos(alive * math.pi * 2) * 0.010),
            right.dy - unit * (0.22 + math.sin(alive * math.pi * 2) * 0.010),
          ),
          unit * (0.042 + pulse * 0.008) * sparkReveal,
        ),
        VisualPaints.fill(visualGold, alpha: 0.86),
      );
      for (var i = 0; i < 7; i++) {
        final stagger = ((alive + i * 0.10) % 1.0);
        final alpha = 0.18 * (1 - stagger) * sparkReveal;
        final angle = i * math.pi / 5 + alive * math.pi * 0.45;
        final start = Offset(
          right.dx + math.cos(angle) * unit * (0.10 + stagger * 0.04),
          right.dy + math.sin(angle) * unit * (0.10 + stagger * 0.04),
        );
        final end = Offset(
          right.dx + math.cos(angle) * unit * (0.15 + stagger * 0.07),
          right.dy + math.sin(angle) * unit * (0.15 + stagger * 0.07),
        );
        canvas.drawLine(
          start,
          end,
          VisualPaints.stroke(visualGold, unit * 0.0045, alpha: alpha),
        );
      }
    }
  }

  void _drawLivingArc(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    Paint paint,
  ) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _FinalQuestionPainter oldDelegate) {
    return oldDelegate.entrance != entrance || oldDelegate.alive != alive;
  }
}
