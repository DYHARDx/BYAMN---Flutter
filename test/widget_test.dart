import 'package:byamn/byamn_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BYAMN app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const ByAmnApp());
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    expect(find.textContaining('BYAMN'), findsWidgets);
  });
}
