import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/app.dart';

void main() {
  testWidgets('App builds and renders bottom navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    expect(find.text('Battle'), findsWidgets);
    expect(find.text('Training'), findsWidgets);
    expect(find.text('Calendar'), findsWidgets);
    expect(find.text('Groups'), findsWidgets);
    expect(find.text('Profile'), findsWidgets);
  });
}
