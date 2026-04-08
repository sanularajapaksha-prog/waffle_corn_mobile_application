import 'package:flutter_test/flutter_test.dart';
import 'package:waffle_corn/main.dart';

void main() {
  testWidgets('WaffleCo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WaffleCo());
    // Splash screen should render without throwing
    expect(find.byType(WaffleCo), findsOneWidget);
  });
}
