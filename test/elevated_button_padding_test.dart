import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:vijaychess/ElevatedButtonWithPadding.dart';

void main() {
  testGoldens('Test elevated button with padding widget',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ElevatedButtonWithPadding(
        child: ElevatedButton(
          child: const Text('Test button'),
          onPressed: () => {},
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();

    expect(find.text('Test button'), findsOneWidget);
    await screenMatchesGolden(tester, 'finds elevated button');
  });
}
