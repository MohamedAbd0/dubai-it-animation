import 'package:flutter/widgets.dart';

import 'custom_scenes/final_question_scene.dart';
import 'custom_scenes/opening_dubai_it_scene.dart';
import 'dubai_it_scene.dart';
import 'visuals/dubai_it_glow_visual.dart';
import 'visuals/excellence_speed_impact_visual.dart';
import 'visuals/exceptional_results_visual.dart';
import 'visuals/execution_visual.dart';
import 'visuals/final_question_visual.dart';
import 'visuals/network_lines_visual.dart';
import 'visuals/promise_action_visual.dart';
import 'visuals/speed_quality_visual.dart';

List<DubaiItScene> buildDubaiItScenes() {
  return [
    DubaiItScene(
      id: 'opening',
      primaryText: 'Dubai-It',
      secondaryText: 'دبي الأفعال',
      primaryDirection: TextDirection.ltr,
      secondaryDirection: TextDirection.rtl,
      sourceLabel: 'Dubai-It Initiative',
      visualBuilder: (_) => const DubaiItGlowVisual(),
      customSceneBuilder: (_) => const OpeningDubaiItScene(),
      duration: const Duration(seconds: 4),
    ),
    DubaiItScene(
      id: 'philosophy',
      primaryText: 'فلسفة دبي في العمل',
      secondaryText: 'Dubai’s philosophy of work',
      primaryDirection: TextDirection.rtl,
      secondaryDirection: TextDirection.ltr,
      sourceLabel: '— HH Sheikh Mohammed bin Rashid',
      visualBuilder: (_) => const NetworkLinesVisual(),
    ),
    DubaiItScene(
      id: 'core_meaning',
      primaryText: 'نتائج استثنائية في وقت قياسي',
      secondaryText: 'Exceptional results in record time',
      primaryDirection: TextDirection.rtl,
      secondaryDirection: TextDirection.ltr,
      sourceLabel: '— HH Sheikh Mohammed bin Rashid',
      visualBuilder: (_) => const ExceptionalResultsVisual(),
    ),
    DubaiItScene(
      id: 'speed_quality',
      primaryText: 'السرعة لا تعني التسرّع\nوالجودة لا تعني البطء',
      secondaryText:
          'Speed does not mean haste\nQuality does not mean slowness',
      primaryDirection: TextDirection.rtl,
      secondaryDirection: TextDirection.ltr,
      sourceLabel: '— HH Sheikh Mohammed bin Rashid',
      visualBuilder: (_) => const SpeedQualityVisual(),
    ),
    DubaiItScene(
      id: 'execution',
      primaryText: 'الطموح لا يكتمل إلا بالتنفيذ',
      secondaryText: 'Ambition is completed through execution',
      primaryDirection: TextDirection.rtl,
      secondaryDirection: TextDirection.ltr,
      sourceLabel: '— HH Sheikh Mohammed bin Rashid',
      visualBuilder: (_) => const ExecutionVisual(),
    ),
    DubaiItScene(
      id: 'hamdan_meaning',
      primaryText:
          'Delivering something exceptional\nwith excellence, speed and impact',
      secondaryText: 'تقديم شيء استثنائي بتميّز وسرعة وتأثير',
      primaryDirection: TextDirection.ltr,
      secondaryDirection: TextDirection.rtl,
      sourceLabel: '— HH Sheikh Hamdan bin Mohammed',
      visualBuilder: (_) => const ExcellenceSpeedImpactVisual(),
    ),
    DubaiItScene(
      id: 'promise_action',
      primaryText: 'نقول ما نفعل… ونفعل ما نقول',
      secondaryText: 'We say what we do… and we do what we say',
      primaryDirection: TextDirection.rtl,
      secondaryDirection: TextDirection.ltr,
      sourceLabel: '— HH Sheikh Mohammed bin Rashid',
      visualBuilder: (_) => const PromiseActionVisual(),
    ),
    DubaiItScene(
      id: 'final_question',
      primaryText: 'Can you Dubai-It?',
      secondaryText: 'هل تستطيع إنجازها بطريقة دبي؟',
      primaryDirection: TextDirection.ltr,
      secondaryDirection: TextDirection.rtl,
      sourceLabel: 'Dubai-It',
      visualBuilder: (_) => const FinalQuestionVisual(),
      customSceneBuilder: (_) => const FinalQuestionScene(),
      duration: const Duration(seconds: 5),
    ),
  ];
}
