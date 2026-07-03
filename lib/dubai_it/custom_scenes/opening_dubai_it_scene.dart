import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../dubai_it_theme.dart';
import '../source_label.dart';

class OpeningDubaiItScene extends StatefulWidget {
  const OpeningDubaiItScene({super.key});

  @override
  State<OpeningDubaiItScene> createState() => _OpeningDubaiItSceneState();
}

class _OpeningDubaiItSceneState extends State<OpeningDubaiItScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = DubaiItLayout.fromSize(
          Size(constraints.maxWidth, constraints.maxHeight),
        );
        final contentWidth =
            (constraints.maxWidth - layout.horizontalPadding * 2).clamp(
              260.0,
              layout.maxWidth,
            );
        final verticalPadding = layout.isShort ? 12.0 : 22.0;
        final safeArea = MediaQuery.of(context).padding;
        final contentHeight = math.max(
          0.0,
          constraints.maxHeight -
              verticalPadding * 2 -
              safeArea.top -
              safeArea.bottom,
        );
        final visualHeight = math.min(
          layout.isMobile ? 150.0 : 210.0,
          contentHeight * (layout.isShort ? 0.30 : 0.34),
        );
        final textHeight = math.min(
          layout.isMobile ? 58.0 : 72.0,
          contentHeight * (layout.isShort ? 0.18 : 0.16),
        );
        final labelHeight = math.min(
          layout.isMobile ? 72.0 : 92.0,
          contentHeight * (layout.isShort ? 0.15 : 0.17),
        );
        final freeHeight = math.max(
          0.0,
          contentHeight - visualHeight - labelHeight,
        );
        final visualTextGap = math.min(
          layout.isMobile ? 8.0 : 12.0,
          freeHeight * 0.08,
        );
        final spacerHeight = math.max(
          0.0,
          freeHeight - textHeight - visualTextGap,
        );
        final topSpacer = spacerHeight * (layout.isShort ? 0.28 : 0.42);
        final bottomSpacer = math.max(0.0, spacerHeight - topSpacer);

        return SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: layout.horizontalPadding,
                vertical: verticalPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: layout.maxWidth),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final value = _controller.value;
                    final dubai = _progress(value, 0.03, 0.23);
                    final suffix = _progress(value, 0.27, 0.47);
                    final lock = _progress(value, 0.52, 0.66);
                    final subtitle = _progress(value, 0.66, 0.80);
                    final label = _progress(value, 0.78, 0.92);
                    final pulse = math.sin(value * math.pi * 6).abs();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: topSpacer),
                        SizedBox(
                          height: visualHeight,
                          width: double.infinity,
                          child: ClipRect(
                            child: RepaintBoundary(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: SizedBox(
                                    width: contentWidth,
                                    child: _OpeningWordMark(
                                      dubaiProgress: dubai,
                                      suffixProgress: suffix,
                                      lockProgress: lock,
                                      pulse: pulse,
                                      fontSize: layout.primarySize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: visualTextGap),
                        SizedBox(
                          height: textHeight,
                          width: double.infinity,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                width: contentWidth,
                                child: _FadeSlide(
                                  progress: subtitle,
                                  offset: const Offset(0, 10),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      'دبي الأفعال',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily:
                                            DubaiItTypography.fontFamily,
                                        fontFamilyFallback:
                                            DubaiItTypography.fallback,
                                        color: Colors.white.withValues(
                                          alpha: 0.72,
                                        ),
                                        fontSize: layout.secondarySize,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: labelHeight,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _FadeSlide(
                              progress: label,
                              offset: const Offset(0, 8),
                              child: SourceLabel(
                                text: 'Dubai-It Initiative',
                                isMobile: layout.isMobile,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: bottomSpacer),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OpeningWordMark extends StatelessWidget {
  final double dubaiProgress;
  final double suffixProgress;
  final double lockProgress;
  final double pulse;
  final double fontSize;

  const _OpeningWordMark({
    required this.dubaiProgress,
    required this.suffixProgress,
    required this.lockProgress,
    required this.pulse,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final glowOpacity = _clamp01(lockProgress * (0.13 + pulse * 0.05));
    final underlineProgress = _clamp01(lockProgress * 1.2);

    return SizedBox(
      height: fontSize * 1.34,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          Opacity(
            opacity: glowOpacity,
            child: Transform.scale(
              scale: 0.92 + pulse * 0.05,
              child: Container(
                width: fontSize * 5.2,
                height: fontSize * 1.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(fontSize),
                  boxShadow: [
                    BoxShadow(
                      color: DubaiItColors.gold.withValues(alpha: 0.42),
                      blurRadius: fontSize * 0.58,
                      spreadRadius: fontSize * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: fontSize * 0.08,
            child: SizedBox(
              width: fontSize * 4.65,
              height: fontSize * 0.28,
              child: ClipRect(
                child: CustomPaint(
                  painter: _GoldSweepPainter(progress: underlineProgress),
                ),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: dubaiProgress,
                  child: Transform.translate(
                    offset: Offset(0, (1 - dubaiProgress) * 10),
                    child: Transform.scale(
                      scale: 0.965 + dubaiProgress * 0.035,
                      child: Text(
                        'Dubai',
                        textAlign: TextAlign.center,
                        style: _primaryStyle(fontSize),
                      ),
                    ),
                  ),
                ),
                _RevealText(
                  progress: suffixProgress,
                  slide: fontSize * 0.40,
                  child: Text(
                    '-It',
                    textAlign: TextAlign.center,
                    style: _primaryStyle(
                      fontSize,
                    ).copyWith(color: Colors.white.withValues(alpha: 0.95)),
                  ),
                ),
                SizedBox(
                  width: fontSize * 0.24,
                  height: fontSize * 0.64,
                  child: Opacity(
                    opacity: _sparkOpacity(suffixProgress, lockProgress),
                    child: ClipRect(
                      child: CustomPaint(
                        painter: _GoldSparkPainter(progress: suffixProgress),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExcludeSemantics(
            child: Opacity(
              opacity: 0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  'Dubai-It',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: _primaryStyle(fontSize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _primaryStyle(double size) {
    return TextStyle(
      fontFamily: DubaiItTypography.fontFamily,
      fontFamilyFallback: DubaiItTypography.fallback,
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 1.08,
    );
  }

  double _sparkOpacity(double suffix, double lock) {
    if (suffix <= 0) {
      return 0;
    }
    return _clamp01((1 - lock) * math.sin(suffix * math.pi));
  }
}

class _RevealText extends StatelessWidget {
  final double progress;
  final double slide;
  final Widget child;

  const _RevealText({
    required this.progress,
    required this.slide,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(slide * (1 - progress), 0),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _GoldSweepPainter extends CustomPainter {
  final double progress;

  const _GoldSweepPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) {
      return;
    }

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          DubaiItColors.gold.withValues(alpha: 0),
          DubaiItColors.gold.withValues(alpha: 0.52 * progress),
          DubaiItColors.gold.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;

    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.48,
        size.height * (0.78 - progress * 0.34),
        size.width * (0.08 + 0.84 * progress),
        size.height * 0.48,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GoldSweepPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _GoldSparkPainter extends CustomPainter {
  final double progress;

  const _GoldSparkPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = math.sin(progress * math.pi).clamp(0.0, 1.0).toDouble();
    if (opacity == 0) {
      return;
    }

    final center = Offset(size.width * 0.52, size.height * 0.46);
    final radius = size.shortestSide * (0.12 + progress * 0.04);
    final paint = Paint()
      ..color = DubaiItColors.gold.withValues(alpha: 0.86 * opacity)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius * 0.32, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + progress * 0.6;
      final from = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      final to =
          center + Offset(math.cos(angle), math.sin(angle)) * radius * 1.55;
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(_GoldSparkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _FadeSlide extends StatelessWidget {
  final double progress;
  final Offset offset;
  final Widget child;

  const _FadeSlide({
    required this.progress,
    required this.offset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(offset.dx * (1 - progress), offset.dy * (1 - progress)),
        child: child,
      ),
    );
  }
}

double _progress(double value, double begin, double end) {
  final raw = ((value - begin) / (end - begin)).clamp(0.0, 1.0).toDouble();
  return Curves.easeOutCubic.transform(raw);
}

double _clamp01(double value) => value.clamp(0.0, 1.0).toDouble();
