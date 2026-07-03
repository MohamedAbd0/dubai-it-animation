import 'package:flutter/material.dart';

import 'dubai_it/dubai_it_animation_screen.dart';
import 'dubai_it/dubai_it_theme.dart';

void main() {
  runApp(const DubaiItApp());
}

class DubaiItApp extends StatelessWidget {
  const DubaiItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dubai-It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: DubaiItTypography.fontFamily,
        scaffoldBackgroundColor: DubaiItColors.bgStart,
      ),
      home: const DubaiItAnimationScreen(loop: false, showReplayButton: true),
    );
  }
}
