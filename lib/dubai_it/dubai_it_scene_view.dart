import 'package:flutter/material.dart';

import 'dubai_it_scene.dart';
import 'dubai_it_theme.dart';
import 'source_label.dart';

class DubaiItSceneView extends StatelessWidget {
  final DubaiItScene scene;

  const DubaiItSceneView({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    final customSceneBuilder = scene.customSceneBuilder;
    if (customSceneBuilder != null) {
      return customSceneBuilder(context);
    }

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

        return SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: layout.horizontalPadding,
                vertical: layout.isShort ? 12 : 22,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: layout.maxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: layout.visualHeight,
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: contentWidth,
                          height: layout.visualHeight,
                          child: scene.visualBuilder(context),
                        ),
                      ),
                    ),
                    SizedBox(height: layout.spacing),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: contentWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Directionality(
                                textDirection: scene.primaryDirection,
                                child: Text(
                                  scene.primaryText,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: DubaiItTypography.fontFamily,
                                    fontFamilyFallback:
                                        DubaiItTypography.fallback,
                                    color: Colors.white,
                                    fontSize: layout.primarySize,
                                    fontWeight: FontWeight.w700,
                                    height: 1.08,
                                  ),
                                ),
                              ),
                              SizedBox(height: layout.isMobile ? 10 : 14),
                              Directionality(
                                textDirection: scene.secondaryDirection,
                                child: Text(
                                  scene.secondaryText,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: DubaiItTypography.fontFamily,
                                    fontFamilyFallback:
                                        DubaiItTypography.fallback,
                                    color: Colors.white.withValues(alpha: 0.72),
                                    fontSize: layout.secondarySize,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: layout.spacing),
                    SourceLabel(
                      text: scene.sourceLabel,
                      isMobile: layout.isMobile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
