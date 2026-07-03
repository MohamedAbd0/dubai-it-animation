import 'package:flutter/material.dart';

abstract final class DubaiItColors {
  static const Color bgStart = Color(0xFF050814);
  static const Color bgMid = Color(0xFF071A2F);
  static const Color bgEnd = Color(0xFF0B2545);
  static const Color gold = Color(0xFFD6A93A);
}

abstract final class DubaiItTypography {
  static const String fontFamily = 'Dubai';
  static const List<String> fallback = ['Arial', 'Roboto', 'sans-serif'];
}

class DubaiItLayout {
  final bool isMobile;
  final bool isTablet;
  final bool isShort;
  final double horizontalPadding;
  final double maxWidth;
  final double primarySize;
  final double secondarySize;
  final double labelSize;
  final double visualHeight;
  final double spacing;

  const DubaiItLayout({
    required this.isMobile,
    required this.isTablet,
    required this.isShort,
    required this.horizontalPadding,
    required this.maxWidth,
    required this.primarySize,
    required this.secondarySize,
    required this.labelSize,
    required this.visualHeight,
    required this.spacing,
  });

  factory DubaiItLayout.fromSize(Size size) {
    final width = size.width;
    final height = size.height;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isShort = height < 560;

    final primary = isMobile ? 33.0 : (isTablet ? 44.0 : 58.0);
    final secondary = isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);
    final reduction = isShort ? 0.86 : 1.0;
    final visualFraction = isShort ? 0.25 : (isMobile ? 0.29 : 0.36);

    return DubaiItLayout(
      isMobile: isMobile,
      isTablet: isTablet,
      isShort: isShort,
      horizontalPadding: isMobile ? 24 : (isTablet ? 56 : 80),
      maxWidth: 900,
      primarySize: primary * reduction,
      secondarySize: secondary * reduction,
      labelSize: isMobile ? 10 : 12,
      visualHeight: (height * visualFraction).clamp(110, isMobile ? 210 : 320),
      spacing: isShort ? 12 : (isMobile ? 18 : 24),
    );
  }
}
