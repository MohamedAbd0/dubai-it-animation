import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'dubai_it_background.dart';
import 'dubai_it_scene_view.dart';
import 'dubai_it_scenes.dart';
import 'dubai_it_theme.dart';

class DubaiItAnimationScreen extends StatefulWidget {
  final bool loop;
  final VoidCallback? onCompleted;
  final bool allowTapToAdvance;
  final bool showReplayButton;

  const DubaiItAnimationScreen({
    super.key,
    this.loop = false,
    this.onCompleted,
    this.allowTapToAdvance = false,
    this.showReplayButton = true,
  });

  @override
  State<DubaiItAnimationScreen> createState() => _DubaiItAnimationScreenState();
}

class _DubaiItAnimationScreenState extends State<DubaiItAnimationScreen> {
  late final _scenes = buildDubaiItScenes();
  int _currentIndex = 0;
  int _playbackToken = 0;
  bool _isCompleted = false;
  Timer? _sceneTimer;
  Completer<bool>? _sceneDelayCompleter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _playFrom(0));
  }

  @override
  void dispose() {
    _playbackToken++;
    _cancelSceneDelay();
    super.dispose();
  }

  Future<void> _playFrom(int startIndex) async {
    final token = ++_playbackToken;
    _cancelSceneDelay();
    if (!mounted) return;

    setState(() {
      _isCompleted = false;
      _currentIndex = startIndex.clamp(0, _scenes.length - 1);
    });

    for (var i = _currentIndex; i < _scenes.length; i++) {
      if (!mounted || token != _playbackToken) return;

      setState(() {
        _currentIndex = i;
      });

      final finishedDelay = await _waitForSceneDuration(_scenes[i].duration);
      if (!finishedDelay) return;
    }

    if (!mounted || token != _playbackToken) return;

    if (widget.loop) {
      unawaited(_playFrom(0));
      return;
    }

    setState(() {
      _isCompleted = true;
    });
    widget.onCompleted?.call();
  }

  void _replay() {
    unawaited(_playFrom(0));
  }

  void _advanceManually() {
    if (!widget.allowTapToAdvance) return;

    _playbackToken++;
    _cancelSceneDelay();
    if (_currentIndex < _scenes.length - 1) {
      setState(() {
        _currentIndex++;
        _isCompleted = false;
      });
      return;
    }

    setState(() {
      _isCompleted = true;
    });
    widget.onCompleted?.call();
  }

  Future<bool> _waitForSceneDuration(Duration duration) {
    _cancelSceneDelay();
    final completer = Completer<bool>();
    _sceneDelayCompleter = completer;
    _sceneTimer = Timer(duration, () {
      _sceneTimer = null;
      if (_sceneDelayCompleter == completer) {
        _sceneDelayCompleter = null;
      }
      if (!completer.isCompleted) {
        completer.complete(true);
      }
    });
    return completer.future;
  }

  void _cancelSceneDelay() {
    _sceneTimer?.cancel();
    _sceneTimer = null;
    final completer = _sceneDelayCompleter;
    _sceneDelayCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scene = _scenes[_currentIndex];

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.allowTapToAdvance ? _advanceManually : null,
        child: DubaiItBackground(
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 720),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, 0.035),
                      end: Offset.zero,
                    ).animate(animation);
                    final scale = Tween<double>(
                      begin: 0.985,
                      end: 1,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: slide,
                        child: ScaleTransition(scale: scale, child: child),
                      ),
                    );
                  },
                  child: DubaiItSceneView(
                    key: ValueKey(scene.id),
                    scene: scene,
                  ),
                ),
              ),
              const Positioned.fill(child: _HeaderOverlay()),
              Positioned.fill(
                child: _ProgressDotsOverlay(
                  currentIndex: _currentIndex,
                  total: _scenes.length,
                ),
              ),
              if (widget.showReplayButton && _isCompleted)
                Positioned(
                  right: 18,
                  bottom: 18,
                  child: _ReplayButton(onPressed: _replay),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressDotsOverlay extends StatelessWidget {
  final int currentIndex;
  final int total;

  const _ProgressDotsOverlay({required this.currentIndex, required this.total});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 16 : 26),
                  child: SceneProgressDots(
                    currentIndex: currentIndex,
                    total: total,
                    isMobile: isMobile,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SceneProgressDots extends StatelessWidget {
  final int currentIndex;
  final int total;
  final bool isMobile;

  const SceneProgressDots({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final inactiveSize = isMobile ? 5.0 : 6.0;
    final activeWidth = isMobile ? 16.0 : 20.0;
    final spacing = isMobile ? 3.0 : 4.0;
    final activeIndex = currentIndex.clamp(0, math.max(total - 1, 0));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final isActive = index == activeIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: isActive ? activeWidth : inactiveSize,
            height: inactiveSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: isActive
                  ? DubaiItColors.gold
                  : Colors.white.withValues(alpha: 0.22),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: DubaiItColors.gold.withValues(alpha: 0.30),
                        blurRadius: isMobile ? 8 : 10,
                        spreadRadius: 0.2,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _HeaderOverlay extends StatefulWidget {
  const _HeaderOverlay();

  @override
  State<_HeaderOverlay> createState() => _HeaderOverlayState();
}

class _HeaderOverlayState extends State<_HeaderOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final horizontal = isMobile ? 18.0 : 28.0;
            final top = isMobile ? 12.0 : 18.0;

            return Padding(
              padding: EdgeInsets.only(left: horizontal, right: horizontal),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final shimmer =
                      (math.sin(_controller.value * math.pi * 2) + 1) / 2;
                  final float = math.sin(
                    _controller.value * math.pi * 2 + math.pi / 3,
                  );

                  return Stack(
                    children: [
                      Positioned(
                        top: top,
                        left: 0,
                        child: _DubaiItHeaderMark(shimmer: shimmer),
                      ),
                      if (!isMobile)
                        Positioned(
                          top: top,
                          right: 0,
                          child: Transform.translate(
                            offset: Offset(0, float * 1.5),
                            child: _FlutterHeaderMark(pulse: shimmer),
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DubaiItHeaderMark extends StatelessWidget {
  final double shimmer;

  const _DubaiItHeaderMark({required this.shimmer});

  @override
  Widget build(BuildContext context) {
    final goldOpacity = 0.46 + shimmer * 0.12;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: DubaiItColors.gold.withValues(alpha: 0.16 + shimmer * 0.06),
          width: 0.8,
        ),
        color: Colors.white.withValues(alpha: 0.025),
        boxShadow: [
          BoxShadow(
            color: DubaiItColors.gold.withValues(alpha: 0.04 + shimmer * 0.03),
            blurRadius: 18,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        child: Text(
          'Dubai-It',
          style: TextStyle(
            fontFamily: DubaiItTypography.fontFamily,
            fontFamilyFallback: DubaiItTypography.fallback,
            color: Color.lerp(
              Colors.white.withValues(alpha: 0.58),
              DubaiItColors.gold.withValues(alpha: goldOpacity),
              0.42,
            ),
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _FlutterHeaderMark extends StatelessWidget {
  final double pulse;

  const _FlutterHeaderMark({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.52 + pulse * 0.08,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            size: const Size(17, 17),
            painter: _FlutterLogoMarkPainter(pulse: pulse),
          ),
          const SizedBox(width: 7),
          Text(
            'Built with Flutter',
            style: TextStyle(
              fontFamily: DubaiItTypography.fontFamily,
              fontFamilyFallback: DubaiItTypography.fallback,
              color: Colors.white.withValues(alpha: 0.56),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlutterLogoMarkPainter extends CustomPainter {
  final double pulse;

  const _FlutterLogoMarkPainter({required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Color.lerp(
      const Color(0xFF54C5F8),
      Colors.white,
      pulse * 0.12,
    )!;
    final darkBlue = Color.lerp(
      const Color(0xFF0B6CBF),
      DubaiItColors.gold,
      pulse * 0.08,
    )!;
    final scale = size.shortestSide / 17;

    canvas.save();
    canvas.scale(scale);

    final top = Path()
      ..moveTo(10.8, 1.0)
      ..lineTo(2.0, 9.8)
      ..lineTo(4.8, 12.6)
      ..lineTo(16.2, 1.0)
      ..close();
    final mid = Path()
      ..moveTo(10.8, 8.0)
      ..lineTo(6.1, 12.7)
      ..lineTo(8.9, 15.5)
      ..lineTo(16.2, 8.0)
      ..close();
    final fold = Path()
      ..moveTo(8.9, 15.5)
      ..lineTo(6.1, 12.7)
      ..lineTo(8.7, 12.7)
      ..lineTo(11.4, 15.5)
      ..close();

    canvas.drawPath(top, Paint()..color = blue.withValues(alpha: 0.82));
    canvas.drawPath(mid, Paint()..color = blue.withValues(alpha: 0.70));
    canvas.drawPath(fold, Paint()..color = darkBlue.withValues(alpha: 0.76));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlutterLogoMarkPainter oldDelegate) {
    return oldDelegate.pulse != pulse;
  }
}

class _ReplayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ReplayButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Replay',
      child: IconButton.filledTonal(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: DubaiItColors.gold.withValues(alpha: 0.12),
          foregroundColor: DubaiItColors.gold,
          side: BorderSide(
            color: DubaiItColors.gold.withValues(alpha: 0.36),
            width: 0.8,
          ),
          fixedSize: const Size.square(42),
        ),
        icon: const Icon(Icons.replay_rounded, size: 20),
      ),
    );
  }
}
