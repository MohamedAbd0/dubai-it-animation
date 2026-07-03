import 'package:flutter/material.dart';

class DubaiItScene {
  final String id;
  final String primaryText;
  final String secondaryText;
  final TextDirection primaryDirection;
  final TextDirection secondaryDirection;
  final String sourceLabel;
  final WidgetBuilder visualBuilder;
  final WidgetBuilder? customSceneBuilder;
  final Duration duration;

  const DubaiItScene({
    required this.id,
    required this.primaryText,
    required this.secondaryText,
    required this.primaryDirection,
    required this.secondaryDirection,
    required this.sourceLabel,
    required this.visualBuilder,
    this.customSceneBuilder,
    this.duration = const Duration(seconds: 3),
  });
}
