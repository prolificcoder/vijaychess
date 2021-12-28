import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:vijaychess/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("failing test example", (WidgetTester tester) async {
    app.main();

    //For web runs Sleep for 2 seconds!!
    //await Future.delayed(const Duration(seconds: 2), () {});
    await tester.pumpAndSettle();

    expect(find.text('Vijay Chess lub'), findsOneWidget);

    await tester.tap(find.text('About'));
  });
}
