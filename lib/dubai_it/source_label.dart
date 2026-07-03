import 'package:flutter/material.dart';

import 'dubai_it_theme.dart';

class SourceLabel extends StatelessWidget {
  final String text;
  final bool isMobile;

  const SourceLabel({super.key, required this.text, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const gold = DubaiItColors.gold;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 9 : 12,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: gold.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: gold.withValues(alpha: 0.45), width: 0.8),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: DubaiItTypography.fontFamily,
          fontFamilyFallback: DubaiItTypography.fallback,
          color: gold,
          fontSize: isMobile ? 10 : 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
