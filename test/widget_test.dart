// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijaychess/main.dart';

void main() {
  testWidgets('Static data test', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('VCC-July').add({
      'first_name': 'Sankalp',
    });
    // Build our app and trigger a frame.
    await tester.pumpWidget(VCCApp());
    await tester.idle();
    await tester.pump();

    // expect(find.text('Vijay Chess Club'), findsOneWidget);
    // expect(find.text('About'), findsOneWidget);
  });
}
