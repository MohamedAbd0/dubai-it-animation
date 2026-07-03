import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../dubai_it_theme.dart';

const visualGold = DubaiItColors.gold;
const visualWhite = Colors.white;

double easeOut(double value) =>
    Curves.easeOutCubic.transform(value.clamp(0, 1));

double interval(double value, double begin, double end) {
  if (value <= begin) return 0;
  if (value >= end) return 1;
  return ((value - begin) / (end - begin)).clamp(0, 1);
}

void drawPartialPath(Canvas canvas, Path path, Paint paint, double progress) {
  final eased = easeOut(progress);
  for (final metric in path.computeMetrics()) {
    final extract = metric.extractPath(0, metric.length * eased);
    canvas.drawPath(extract, paint);
  }
}

void drawCheck(Canvas canvas, Offset center, double size, Paint paint) {
  final path = Path()
    ..moveTo(center.dx - size * 0.42, center.dy - size * 0.02)
    ..lineTo(center.dx - size * 0.12, center.dy + size * 0.28)
    ..lineTo(center.dx + size * 0.46, center.dy - size * 0.34);
  drawPartialPath(canvas, path, paint, 1);
}

Offset lerpOffset(Offset a, Offset b, double t) {
  return Offset.lerp(a, b, easeOut(t)) ?? b;
}

class VisualPaints {
  static Paint stroke(Color color, double width, {double alpha = 1}) {
    return Paint()
      ..color = color.withValues(alpha: alpha)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = width;
  }

  static Paint fill(Color color, {double alpha = 1}) {
    return Paint()
      ..color = color.withValues(alpha: alpha)
      ..style = PaintingStyle.fill;
  }

  static Paint glow(Size size, Offset center, double radius, double alpha) {
    return Paint()
      ..shader = RadialGradient(
        colors: [
          visualGold.withValues(alpha: alpha),
          visualGold.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
  }
}

class AnimatedVisualFrame extends StatefulWidget {
  final Duration duration;
  final CustomPainter Function(double progress) painterBuilder;

  const AnimatedVisualFrame({
    super.key,
    required this.painterBuilder,
    this.duration = const Duration(milliseconds: 1600),
  });

  @override
  State<AnimatedVisualFrame> createState() => _AnimatedVisualFrameState();
}

class _AnimatedVisualFrameState extends State<AnimatedVisualFrame>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();
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
        builder: (context, _) {
          return CustomPaint(
            painter: widget.painterBuilder(_controller.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

Path starPath(Offset center, double radius) {
  final path = Path();
  for (var i = 0; i < 10; i++) {
    final angle = -math.pi / 2 + i * math.pi / 5;
    final r = i.isEven ? radius : radius * 0.42;
    final point = Offset(
      center.dx + math.cos(angle) * r,
      center.dy + math.sin(angle) * r,
    );
    if (i == 0) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
  }
  path.close();
  return path;
}
