import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../dubai_it_theme.dart';
import '../source_label.dart';
import '../visuals/final_question_visual.dart';

class FinalQuestionScene extends StatefulWidget {
  const FinalQuestionScene({super.key});

  @override
  State<FinalQuestionScene> createState() => _FinalQuestionSceneState();
}

class _FinalQuestionSceneState extends State<FinalQuestionScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
          layout.isMobile ? 150.0 : 220.0,
          contentHeight * (layout.isShort ? 0.28 : 0.33),
        );
        final textHeight = math.min(
          layout.isMobile ? 170.0 : 230.0,
          contentHeight * (layout.isShort ? 0.46 : 0.48),
        );
        final labelHeight = math.min(
          layout.isMobile ? 72.0 : 92.0,
          contentHeight * (layout.isShort ? 0.15 : 0.17),
        );
        final freeHeight = math.max(
          0.0,
          contentHeight - visualHeight - labelHeight,
        );
        final visualTextGap = math.min(layout.spacing * 1.1, freeHeight * 0.14);
        final spacerHeight = math.max(
          0.0,
          freeHeight - textHeight - visualTextGap,
        );
        final topSpacer = spacerHeight * (layout.isShort ? 0.22 : 0.34);
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
                    final canYou = _progress(value, 0.04, 0.22);
                    final dubai = _progress(value, 0.22, 0.42);
                    final it = _progress(value, 0.40, 0.56);
                    final lock = _progress(value, 0.56, 0.70);
                    final subtitle = _progress(value, 0.70, 0.84);
                    final label = _progress(value, 0.82, 0.94);
                    final pulse = math.sin(value * math.pi * 8).abs();

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
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: contentWidth,
                                    height: visualHeight,
                                    child: const FinalQuestionVisual(),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _QuestionWordMark(
                                      canYouProgress: canYou,
                                      dubaiProgress: dubai,
                                      itProgress: it,
                                      lockProgress: lock,
                                      pulse: pulse,
                                      fontSize: layout.primarySize,
                                    ),
                                    SizedBox(height: layout.isMobile ? 10 : 14),
                                    _FadeSlide(
                                      progress: subtitle,
                                      offset: const Offset(0, 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          'هل تستطيع إنجازها بطريقة دبي؟',
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
                                  ],
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
                                text: 'Dubai-It',
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

class _QuestionWordMark extends StatelessWidget {
  final double canYouProgress;
  final double dubaiProgress;
  final double itProgress;
  final double lockProgress;
  final double pulse;
  final double fontSize;

  const _QuestionWordMark({
    required this.canYouProgress,
    required this.dubaiProgress,
    required this.itProgress,
    required this.lockProgress,
    required this.pulse,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final highlightOpacity = _clamp01(dubaiProgress * (1 - lockProgress));
    final lockGlow = _clamp01(lockProgress * (0.08 + pulse * 0.04));

    return SizedBox(
      height: fontSize * 1.48,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          Opacity(
            opacity: highlightOpacity * (0.14 + pulse * 0.08),
            child: Transform.scale(
              scale: 0.92 + dubaiProgress * 0.09 + pulse * 0.025,
              child: Container(
                width: fontSize * 2.55,
                height: fontSize * 0.94,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(fontSize),
                  boxShadow: [
                    BoxShadow(
                      color: DubaiItColors.gold.withValues(alpha: 0.52),
                      blurRadius: fontSize * 0.48,
                      spreadRadius: fontSize * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Opacity(
            opacity: lockGlow,
            child: Container(
              width: fontSize * 6.8,
              height: fontSize * 1.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(fontSize),
                boxShadow: [
                  BoxShadow(
                    color: DubaiItColors.gold.withValues(alpha: 0.34),
                    blurRadius: fontSize * 0.46,
                    spreadRadius: fontSize * 0.02,
                  ),
                ],
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
                  opacity: canYouProgress,
                  child: Transform.translate(
                    offset: Offset(0, (1 - canYouProgress) * 8),
                    child: Transform.scale(
                      scale: 0.965 + canYouProgress * 0.035,
                      child: Text('Can you', style: _plainStyle(fontSize)),
                    ),
                  ),
                ),
                _RevealGap(progress: dubaiProgress, width: fontSize * 0.16),
                _RevealWord(
                  progress: dubaiProgress,
                  slide: fontSize * 0.24,
                  scaleStart: 0.93,
                  scaleEnd: 1.045,
                  child: Text(
                    'Dubai',
                    style: _plainStyle(fontSize).copyWith(
                      color: Color.lerp(
                        Colors.white,
                        DubaiItColors.gold,
                        0.34 + pulse * 0.07,
                      ),
                    ),
                  ),
                ),
                _RevealWord(
                  progress: itProgress,
                  slide: fontSize * 0.26,
                  scaleStart: 0.98,
                  child: Text(
                    '-It?',
                    style: _plainStyle(
                      fontSize,
                    ).copyWith(color: Colors.white.withValues(alpha: 0.96)),
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
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Can you ', style: _plainStyle(fontSize)),
                      TextSpan(
                        text: 'Dubai',
                        style: _plainStyle(fontSize).copyWith(
                          color: Color.lerp(
                            Colors.white,
                            DubaiItColors.gold,
                            0.30,
                          ),
                        ),
                      ),
                      TextSpan(text: '-It?', style: _plainStyle(fontSize)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Positioned(
            right: fontSize * 0.10,
            top: fontSize * 0.08,
            child: Opacity(
              opacity: _questionBurstOpacity(itProgress, lockProgress),
              child: ClipRect(
                child: CustomPaint(
                  size: Size(fontSize * 0.48, fontSize * 0.48),
                  painter: _QuestionBurstPainter(progress: itProgress),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _plainStyle(double size) {
    return TextStyle(
      fontFamily: DubaiItTypography.fontFamily,
      fontFamilyFallback: DubaiItTypography.fallback,
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 1.08,
    );
  }

  double _questionBurstOpacity(double it, double lock) {
    if (it <= 0) {
      return 0;
    }
    return _clamp01((1 - lock * 0.55) * math.sin(it * math.pi));
  }
}

class _RevealGap extends StatelessWidget {
  final double progress;
  final double width;

  const _RevealGap({required this.progress, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width * progress);
  }
}

class _RevealWord extends StatelessWidget {
  final double progress;
  final double slide;
  final double scaleStart;
  final double scaleEnd;
  final Widget child;

  const _RevealWord({
    required this.progress,
    required this.slide,
    required this.child,
    this.scaleStart = 0.96,
    this.scaleEnd = 1,
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
            child: Transform.scale(
              scale: scaleStart + (scaleEnd - scaleStart) * progress,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionBurstPainter extends CustomPainter {
  final double progress;

  const _QuestionBurstPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = math.sin(progress * math.pi).clamp(0.0, 1.0).toDouble();
    if (opacity == 0) {
      return;
    }

    final center = Offset(size.width * 0.48, size.height * 0.54);
    final paint = Paint()
      ..color = DubaiItColors.gold.withValues(alpha: 0.82 * opacity)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.9;

    final burst = size.shortestSide * (0.16 + progress * 0.18);
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * math.pi * 0.24 + progress * 0.3;
      final inner = center + Offset(math.cos(angle), math.sin(angle)) * burst;
      final outer =
          center + Offset(math.cos(angle), math.sin(angle)) * burst * 1.85;
      canvas.drawLine(inner, outer, paint);
    }

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, size.shortestSide * 0.06, paint);
  }

  @override
  bool shouldRepaint(_QuestionBurstPainter oldDelegate) {
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
