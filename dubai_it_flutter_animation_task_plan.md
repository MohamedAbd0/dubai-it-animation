# Dubai-it Native Flutter Web Animation — Full Implementation Task Plan

## Project Goal

Build a polished **Flutter Web demo page** for **Dubai-it / دبي الأفعال**, designed as a public GitHub Pages project.

The page should present the Dubai-it philosophy through a short native Flutter animation using Arabic and English text, source labels, and simple motion graphics drawn directly with Flutter.

This is a **public demo / portfolio-quality project**, not an enterprise production app.

---

## 1. Core Requirements

### Must Have

Build a Flutter Web animation screen with:

1. Native Flutter animations only.
2. No Lottie.
3. No Rive.
4. No video.
5. No external animation assets.
6. Arabic + English text.
7. Dubai Font.
8. Dark navy luxury background.
9. Gold visual accents.
10. Small gold source labels.
11. Responsive layout for mobile and web.
12. Auto-play animation.
13. Final question screen.
14. GitHub Pages deployment support.
15. FVM for Flutter SDK management.

---

## 2. Flutter Version and FVM

Use **FVM** and the latest Flutter stable version available at implementation time.

Do not rely on the global Flutter installation.

### Required Commands

```bash
dart pub global activate fvm
fvm install stable
fvm use stable
```

Create the project:

```bash
fvm flutter create dubai_it_animation
cd dubai_it_animation
fvm flutter pub get
```

Run locally:

```bash
fvm flutter run -d chrome
```

Build for web:

```bash
fvm flutter build web --release
```

Build for GitHub Pages:

```bash
fvm flutter build web --release --base-href /REPO_NAME/
```

Replace `REPO_NAME` with the actual GitHub repository name.

### Required Files

Commit:

```text
.fvmrc
```

Do not commit large generated build outputs unless specifically needed.

---

## 3. Project Type

This project is:

```text
Flutter Web demo
GitHub Pages ready
Native Flutter animation
Public portfolio-quality code
```

This project is not:

```text
Enterprise production app
Backend app
CMS
Admin panel
Authentication app
Database app
```

Do not add unnecessary packages or architecture.

---

## 4. Package Rules

Avoid unnecessary packages.

Preferred:

```text
Flutter SDK only
```

Do not use:

```text
lottie
rive
video_player
animation asset packages
state management packages
routing packages
```

Use simple Flutter built-in tools:

```text
AnimationController
AnimatedSwitcher
FadeTransition
SlideTransition
ScaleTransition
CustomPainter
LayoutBuilder
ConstrainedBox
FittedBox
TickerProviderStateMixin
```

---

## 5. Visual Identity

### Background

Use a premium dark navy gradient.

Colors:

```dart
const Color bgStart = Color(0xFF050814); // near black navy
const Color bgMid = Color(0xFF071A2F);   // deep navy
const Color bgEnd = Color(0xFF0B2545);   // royal dark blue
```

Gold accent:

```dart
const Color gold = Color(0xFFD6A93A);
```

Text colors:

```text
Main text: Colors.white
Secondary text: Colors.white.withOpacity(0.72)
Source label text: Color(0xFFD6A93A)
Source label border: Color(0xFFD6A93A).withOpacity(0.45)
Source label background: Color(0xFFD6A93A).withOpacity(0.10)
```

### Visual Style

The style should feel:

```text
premium
official
minimal
Dubai-inspired
dark luxury
clear
not noisy
```

Avoid visual clutter.

Background motion should be subtle:

```text
soft gold glow
few abstract lines
few light particles
slow movement
```

Maximum suggested particles:

```text
12 particles
```

No heavy blur effects.

---

## 6. Typography

Use **Dubai Font** for all text.

### Font Assets

Expected structure:

```text
assets/
  fonts/
    Dubai-Regular.ttf
    Dubai-Medium.ttf
    Dubai-Bold.ttf
```

### pubspec.yaml

```yaml
flutter:
  assets:
    - assets/fonts/

  fonts:
    - family: Dubai
      fonts:
        - asset: assets/fonts/Dubai-Regular.ttf
          weight: 400
        - asset: assets/fonts/Dubai-Medium.ttf
          weight: 500
        - asset: assets/fonts/Dubai-Bold.ttf
          weight: 700
```

### Font Usage

| Element | Font | Weight |
|---|---|---|
| Main quote | Dubai | 700 |
| Secondary subtitle | Dubai | 400 or 500 |
| Source label | Dubai | 500 |
| Final question | Dubai | 700 |

Use fallback fonts so the app still compiles if Dubai Font files are missing during early development.

Example:

```dart
fontFamily: 'Dubai',
fontFamilyFallback: ['Arial', 'Roboto', 'sans-serif'],
```

---

## 7. Approved Script

Use this exact script.

Do not rewrite, paraphrase, add, or remove quotes unless explicitly requested.

Total scenes:

```text
8 scenes
```

Expected duration:

```text
22–28 seconds
```

---

### Scene 1 — Opening

Primary text:

```text
Dubai-it
```

Secondary text:

```text
دبي الأفعال
```

Source label:

```text
Dubai-it Initiative
```

Visual:

```text
Dubai-it glow reveal
soft gold pulse behind the text
```

Primary direction:

```text
LTR
```

Secondary direction:

```text
RTL
```

Duration:

```text
3 seconds
```

---

### Scene 2 — Philosophy

Primary text:

```text
فلسفة دبي في العمل
```

Secondary text:

```text
Dubai’s philosophy of work
```

Source label:

```text
— HH Sheikh Mohammed bin Rashid
```

Visual:

```text
Connected dots and lines forming a clear execution path
```

Primary direction:

```text
RTL
```

Secondary direction:

```text
LTR
```

Duration:

```text
3 seconds
```

---

### Scene 3 — Core Meaning

Primary text:

```text
نتائج استثنائية في وقت قياسي
```

Secondary text:

```text
Exceptional results in record time
```

Source label:

```text
— HH Sheikh Mohammed bin Rashid
```

Visual:

```text
Rising arrow with simple clock or speed indicator
```

Primary direction:

```text
RTL
```

Secondary direction:

```text
LTR
```

Duration:

```text
3 seconds
```

---

### Scene 4 — Speed & Quality

Primary text:

```text
السرعة لا تعني التسرّع
والجودة لا تعني البطء
```

Secondary text:

```text
Speed does not mean haste
Quality does not mean slowness
```

Source label:

```text
— HH Sheikh Mohammed bin Rashid
```

Visual:

```text
Fast but stable arrow line ending with a clean check mark
```

Primary direction:

```text
RTL
```

Secondary direction:

```text
LTR
```

Duration:

```text
3 seconds
```

---

### Scene 5 — Execution

Primary text:

```text
الطموح لا يكتمل إلا بالتنفيذ
```

Secondary text:

```text
Ambition is completed through execution
```

Source label:

```text
— HH Sheikh Mohammed bin Rashid
```

Visual:

```text
Idea spark transforming into a mountain peak or achievement mark
```

Primary direction:

```text
RTL
```

Secondary direction:

```text
LTR
```

Duration:

```text
3 seconds
```

---

### Scene 6 — Hamdan Meaning

Primary text:

```text
Delivering something exceptional
with excellence, speed and impact
```

Secondary text:

```text
تقديم شيء استثنائي بتميّز وسرعة وتأثير
```

Source label:

```text
— HH Sheikh Hamdan bin Mohammed
```

Visual:

```text
Three circles or pillars labelled conceptually as Excellence, Speed, Impact merging into one gold point
```

Primary direction:

```text
LTR
```

Secondary direction:

```text
RTL
```

Duration:

```text
3 seconds
```

---

### Scene 7 — Promise & Action

Primary text:

```text
نقول ما نفعل… ونفعل ما نقول
```

Secondary text:

```text
We say what we do… and we do what we say
```

Source label:

```text
— HH Sheikh Mohammed bin Rashid
```

Visual:

```text
Words transform into an action line ending with a gold check mark
```

Primary direction:

```text
RTL
```

Secondary direction:

```text
LTR
```

Duration:

```text
3 seconds
```

---

### Scene 8 — Final Question

Primary text:

```text
Can you Dubai it?
```

Secondary text:

```text
هل تستطيع إنجازها بطريقة دبي؟
```

Source label:

```text
Dubai-it
```

Visual:

```text
Dubai-it appears large
question mark transforms into a gold arrow, star, or light burst
```

Primary direction:

```text
LTR
```

Secondary direction:

```text
RTL
```

Duration:

```text
4 seconds
```

---

## 8. Scene Model

Use a clean scene model.

Do not use `titleAr/titleEn/englishFirst`.

Use generic primary and secondary text because some scenes are Arabic-first and some are English-first.

```dart
class DubaiItScene {
  final String id;
  final String primaryText;
  final String secondaryText;
  final TextDirection primaryDirection;
  final TextDirection secondaryDirection;
  final String sourceLabel;
  final WidgetBuilder visualBuilder;
  final Duration duration;

  const DubaiItScene({
    required this.id,
    required this.primaryText,
    required this.secondaryText,
    required this.primaryDirection,
    required this.secondaryDirection,
    required this.sourceLabel,
    required this.visualBuilder,
    this.duration = const Duration(seconds: 3),
  });
}
```

Use `WidgetBuilder visualBuilder` instead of storing a `Widget` directly, so each scene can rebuild and replay its animation cleanly.

---

## 9. Scene List

Create a function:

```dart
List<DubaiItScene> buildDubaiItScenes()
```

This should return the approved 8 scenes.

Example:

```dart
DubaiItScene(
  id: 'opening',
  primaryText: 'Dubai-it',
  secondaryText: 'دبي الأفعال',
  primaryDirection: TextDirection.ltr,
  secondaryDirection: TextDirection.rtl,
  sourceLabel: 'Dubai-it Initiative',
  visualBuilder: (_) => const DubaiItGlowVisual(),
),
```

For final scene:

```dart
DubaiItScene(
  id: 'final_question',
  primaryText: 'Can you Dubai it?',
  secondaryText: 'هل تستطيع إنجازها بطريقة دبي؟',
  primaryDirection: TextDirection.ltr,
  secondaryDirection: TextDirection.rtl,
  sourceLabel: 'Dubai-it',
  visualBuilder: (_) => const FinalQuestionVisual(),
  duration: Duration(seconds: 4),
),
```

---

## 10. Screen Public API

Create:

```dart
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
}
```

Default behavior:

```text
auto-play starts immediately
loop is false
stops on final scene
shows replay button after completion
```

Optional behavior:

```text
if loop = true, restart after final scene
if allowTapToAdvance = true, tapping moves to next scene
if onCompleted is provided, call it after final scene duration
```

Keep UI clean. Replay button should be small and subtle.

---

## 11. Animation Timing

Use simple and reliable sequencing.

Scene duration:

```text
3 seconds
```

Final scene duration:

```text
4 seconds
```

Transition duration:

```text
650–750ms
```

Visual animation duration:

```text
1400–1800ms
```

Recommended transition:

```text
Fade + slight slide up + slight scale
```

Use:

```dart
AnimatedSwitcher
FadeTransition
SlideTransition
ScaleTransition
```

Do not make transitions too dramatic.

---

## 12. Playback Logic

Keep playback simple.

Do not over-engineer.

Use either:

```text
Future.delayed sequence
```

or:

```text
Timer-based sequence
```

Preferred simple sequence:

```dart
Future<void> _play() async {
  setState(() {
    _isCompleted = false;
  });

  for (var i = currentIndex; i < scenes.length; i++) {
    if (!mounted) return;

    setState(() {
      currentIndex = i;
    });

    await Future.delayed(scenes[i].duration);
  }

  if (!mounted) return;

  if (widget.loop) {
    currentIndex = 0;
    await _play();
  } else {
    setState(() {
      _isCompleted = true;
    });
    widget.onCompleted?.call();
  }
}
```

Important:

```text
Avoid multiple playback loops running at the same time.
Cancel or guard playback on dispose.
```

Use a playback token or boolean guard if needed.

---

## 13. Responsive Layout

Must support:

```text
mobile portrait
mobile landscape
tablet
desktop web
```

Use:

```dart
LayoutBuilder
ConstrainedBox(maxWidth: 900)
FittedBox for visuals
MediaQuery size
```

Breakpoints:

```dart
mobile: width < 600
tablet: width >= 600 && width < 1024
desktop: width >= 1024
```

Recommended sizes:

| Element | Mobile | Tablet | Desktop/Web |
|---|---:|---:|---:|
| Primary text | 30–34 | 40–46 | 52–60 |
| Secondary text | 15–17 | 19–21 | 22–26 |
| Label | 10 | 11 | 12 |
| Visual height | 25–30% | 30–34% | 34–38% |
| Horizontal padding | 22–28 | 48–64 | 80 |

Composition rule:

```text
Visual area: around 35%
Text area: around 45%
Label and spacing: around 20%
```

On short screens:

```text
reduce visual height first
then reduce text size
do not overflow text
```

On desktop/web:

```text
center content
max width 900
do not stretch text across full screen
```

---

## 14. Text Direction Rules

Each text widget must explicitly set direction.

Arabic:

```dart
textDirection: TextDirection.rtl
```

English:

```dart
textDirection: TextDirection.ltr
```

Do not rely on app-level directionality.

Primary text direction comes from:

```dart
scene.primaryDirection
```

Secondary text direction comes from:

```dart
scene.secondaryDirection
```

---

## 15. Text Scaling

Keep text readable but avoid layout breakage.

Use responsive font sizes.

Avoid uncontrolled huge system text scaling breaking the hero animation.

Suggested:

```text
Support text scaling up to a reasonable limit.
Cap hero text scaling around 1.15–1.2 if needed.
```

No external package required.

---

## 16. Source Label Design

Small gold pill/chip.

Requirements:

```text
must be smaller than quote text
must not dominate the screen
gold text
gold border
transparent gold background
rounded pill shape
```

Suggested widget:

```dart
class SourceLabel extends StatelessWidget {
  final String text;
  final bool isMobile;

  const SourceLabel({
    super.key,
    required this.text,
    this.isMobile = true,
  });

  @override
  Widget build(BuildContext context) {
    const gold = DubaiItColors.gold;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 9 : 12,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: gold.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: gold.withOpacity(0.45),
          width: 0.8,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Dubai',
          fontFamilyFallback: const ['Arial', 'Roboto', 'sans-serif'],
          color: gold,
          fontSize: isMobile ? 10 : 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
```

---

## 17. Required Visual Widgets

Create 8 native visual widgets using `CustomPainter`.

### 1. DubaiItGlowVisual

For scene:

```text
Dubai-it
```

Motion:

```text
gold radial pulse
subtle glow
simple reveal
```

---

### 2. NetworkLinesVisual

For scene:

```text
فلسفة دبي في العمل
```

Motion:

```text
dots appear
lines connect dots
path becomes clear
```

---

### 3. ExceptionalResultsVisual

For scene:

```text
نتائج استثنائية في وقت قياسي
```

Motion:

```text
rising arrow draws itself
small clock/speed ring animates
```

---

### 4. SpeedQualityVisual

For scene:

```text
السرعة لا تعني التسرّع
والجودة لا تعني البطء
```

Motion:

```text
fast stable line
small motion streaks
ends with check mark
```

---

### 5. ExecutionVisual

For scene:

```text
الطموح لا يكتمل إلا بالتنفيذ
```

Motion:

```text
spark or idea point appears
line climbs toward peak
gold achievement mark appears
```

---

### 6. ExcellenceSpeedImpactVisual

For scene:

```text
Delivering something exceptional
with excellence, speed and impact
```

Motion:

```text
three circles/pillars appear
they move toward center
merge into one gold point
```

Optional tiny labels inside/under circles:

```text
Excellence
Speed
Impact
```

Keep labels minimal and readable. If too crowded on mobile, omit labels and use icons/shapes only.

---

### 7. PromiseActionVisual

For scene:

```text
نقول ما نفعل… ونفعل ما نقول
```

Motion:

```text
two short line segments appear
connect into one action path
path ends with gold check mark
```

---

### 8. FinalQuestionVisual

For scene:

```text
Can you Dubai it?
```

Motion:

```text
question mark draws itself
transforms visually into arrow/star/light burst
gold final pulse
```

---

## 18. CustomPainter Guidelines

Each visual must:

```text
use size.width and size.height
not depend on fixed absolute dimensions
animate based on progress value
use white and gold colors only
stay minimal
complete within 1.4–1.8 seconds
```

Performance:

```text
wrap each visual in RepaintBoundary
avoid heavy blur
avoid excessive particles
avoid expensive canvas operations
implement shouldRepaint correctly
```

Example pattern:

```dart
class SpeedQualityVisual extends StatefulWidget {
  const SpeedQualityVisual({super.key});

  @override
  State<SpeedQualityVisual> createState() => _SpeedQualityVisualState();
}

class _SpeedQualityVisualState extends State<SpeedQualityVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();
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
        builder: (_, __) {
          return CustomPaint(
            painter: SpeedQualityPainter(_controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}
```

---

## 19. Background Widget

Create:

```dart
DubaiItBackground
```

It should:

```text
draw dark navy gradient
draw one soft radial gold glow
draw a few slow moving abstract lines or particles
stay subtle
not distract from text
```

Can use:

```dart
AnimatedBuilder
CustomPainter
AnimationController.repeat()
```

Keep it low-cost.

---

## 20. Suggested File Structure

Use this simple structure:

```text
lib/
  main.dart

  dubai_it/
    dubai_it_animation_screen.dart
    dubai_it_scene.dart
    dubai_it_scenes.dart
    dubai_it_theme.dart
    dubai_it_background.dart
    dubai_it_scene_view.dart
    source_label.dart

    visuals/
      dubai_it_glow_visual.dart
      network_lines_visual.dart
      exceptional_results_visual.dart
      speed_quality_visual.dart
      execution_visual.dart
      excellence_speed_impact_visual.dart
      promise_action_visual.dart
      final_question_visual.dart

assets/
  fonts/
    Dubai-Regular.ttf
    Dubai-Medium.ttf
    Dubai-Bold.ttf

.github/
  workflows/
    deploy.yml

README.md
```

Keep it simple.

No need for Clean Architecture.

No need for feature/domain/data layers.

---

## 21. main.dart

Create a minimal app.

```dart
void main() {
  runApp(const DubaiItApp());
}

class DubaiItApp extends StatelessWidget {
  const DubaiItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dubai-it',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Dubai',
        scaffoldBackgroundColor: DubaiItColors.bgStart,
      ),
      home: const DubaiItAnimationScreen(
        loop: false,
        showReplayButton: true,
      ),
    );
  }
}
```

---

## 22. GitHub Pages Deployment

Add GitHub Actions workflow.

Path:

```text
.github/workflows/deploy.yml
```

Expected behavior:

```text
on push to main
install Flutter using FVM or stable channel
run flutter pub get
build web release with base href
deploy build/web to GitHub Pages
```

Use FVM where possible.

The code agent should create a clean workflow and document any repo-name variable.

Required build command:

```bash
fvm flutter build web --release --base-href /REPO_NAME/
```

If GitHub Actions uses Flutter action instead of FVM, it must still respect the version/channel defined in `.fvmrc` if possible.

README must explain how to change the `base-href`.

---

## 23. README Requirements

Create a clear README with:

1. Project title:

```text
Dubai-it Native Flutter Animation
```

2. Short description:

```text
A native Flutter Web animation explaining Dubai-it / دبي الأفعال using Arabic and English text, Dubai Font, dark navy visuals, and gold motion accents.
```

3. Features:

```text
Native Flutter animation
No Lottie/Rive/video
Responsive mobile/web
CustomPainter visuals
Dubai Font
GitHub Pages ready
```

4. Requirements:

```text
FVM
Flutter stable
Chrome for local web run
```

5. Setup:

```bash
dart pub global activate fvm
fvm install stable
fvm use stable
fvm flutter pub get
```

6. Run:

```bash
fvm flutter run -d chrome
```

7. Build:

```bash
fvm flutter build web --release
```

8. Build for GitHub Pages:

```bash
fvm flutter build web --release --base-href /REPO_NAME/
```

9. Font note:

```text
Dubai Font files should be placed under assets/fonts.
```

10. License note:

```text
Do not include font license text unless available. If font files are not committed, explain how to add them locally.
```

---

## 24. Git Ignore

Ensure `.gitignore` is clean for Flutter.

Do not commit:

```text
build/
.dart_tool/
.packages
.flutter-plugins
.flutter-plugins-dependencies
```

FVM:

Usually commit:

```text
.fvmrc
```

Usually do not commit:

```text
.fvm/flutter_sdk
```

---

## 25. Acceptance Criteria

Implementation is complete when:

1. Project runs with:

```bash
fvm flutter run -d chrome
```

2. Project builds with:

```bash
fvm flutter build web --release
```

3. The screen auto-plays the approved 8 scenes.

4. The final scene displays:

```text
Can you Dubai it?
هل تستطيع إنجازها بطريقة دبي؟
```

5. All scenes include:

```text
primary text
secondary text
source label
native animated visual
```

6. No Lottie, Rive, or video package is used.

7. All visuals are implemented using Flutter widgets and/or CustomPainter.

8. Background is dark navy gradient with subtle gold accents.

9. Dubai Font is used across the UI, with fallback fonts.

10. Layout is responsive on:

```text
mobile web
desktop web
tablet width
```

11. Source labels are small gold pills and never visually dominate the quote.

12. Text does not overflow on common screen sizes.

13. Replay button appears after completion.

14. GitHub Pages deployment workflow exists.

15. README explains setup, run, build, and deploy.

16. Code is clean, simple, and easy to modify.

---

## 26. Implementation Priority

Follow this order:

### Phase 1 — Project Setup

1. Create Flutter project using FVM.
2. Configure `.fvmrc`.
3. Add Dubai Font assets and `pubspec.yaml` setup.
4. Create basic `main.dart`.
5. Confirm app runs on Chrome.

### Phase 2 — Theme and Layout

1. Create `dubai_it_theme.dart`.
2. Create background widget.
3. Create scene model.
4. Create scene list.
5. Create responsive scene view.
6. Create source label widget.

### Phase 3 — Scene Player

1. Create `DubaiItAnimationScreen`.
2. Implement scene sequencing.
3. Add `AnimatedSwitcher` transition.
4. Add replay support.
5. Add optional tap-to-advance support.

### Phase 4 — Native Visuals

Implement visuals in this order:

1. `DubaiItGlowVisual`
2. `SpeedQualityVisual`
3. `PromiseActionVisual`
4. `ExceptionalResultsVisual`
5. `NetworkLinesVisual`
6. `ExecutionVisual`
7. `ExcellenceSpeedImpactVisual`
8. `FinalQuestionVisual`

Start with simple polished visuals. Do not overcomplicate.

### Phase 5 — Responsive Polish

1. Test mobile portrait.
2. Test desktop web.
3. Test narrow width.
4. Test landscape height.
5. Adjust font sizes and visual heights.
6. Ensure no overflow.

### Phase 6 — GitHub Pages

1. Add GitHub Actions workflow.
2. Add README instructions.
3. Test release build.
4. Confirm base-href instructions are clear.

---

## 27. Important Notes for Code Agent

- Keep the project simple.
- Do not over-engineer.
- This is a GitHub Pages demo.
- Do not add backend.
- Do not add state management packages.
- Do not add routing unless needed.
- Do not add Lottie, Rive, or video.
- Do not rewrite the script.
- Do not attribute new text to the sheikhs.
- Keep visuals elegant and minimal.
- Prioritize readability and polish over complexity.
- Make the code easy to edit later.

---

## 28. Final Instruction

Implement this exact Flutter Web demo according to the plan.

The final output should be a clean, responsive, native Flutter animation page ready to publish on GitHub Pages.
