import 'package:dubai_it_animation/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the opening Dubai-It scene', (tester) async {
    await tester.pumpWidget(const DubaiItApp());

    expect(find.text('Dubai-It'), findsAtLeastNWidgets(1));
    expect(find.text('دبي الأفعال'), findsOneWidget);
    expect(find.text('Dubai-It Initiative'), findsOneWidget);
  });
}
