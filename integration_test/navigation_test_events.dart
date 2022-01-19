import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:vijaychess/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Verify navigations work for events",
      (WidgetTester tester) async {
    app.main();

    //For web runs Sleep for 2 seconds!!
    await Future.delayed(const Duration(seconds: 2), () {});
    await tester.pumpAndSettle();

    await tester.tap(find.text('List all events'));

    await tester.pumpAndSettle();

    expect(find.text('Events list'), findsOneWidget);

    await tester.tap(find.text('Create new event'));

    await tester.pumpAndSettle();

    expect(find.text('Create event'), findsOneWidget);
  });
}
