// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:vijaychess/ElevatedButtonWithPadding.dart';

void main() {
  testWidgets('Test elevated button with padding widget',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
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
  });
}
