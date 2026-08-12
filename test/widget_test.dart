import 'package:flutter_test/flutter_test.dart';
import 'package:kiit_sync/main.dart';

void main() {
  testWidgets('KIIT SYNC app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const KiitSyncApp());
    expect(find.text('Welcome to KIIT SYNC'), findsOneWidget);
  });
}
