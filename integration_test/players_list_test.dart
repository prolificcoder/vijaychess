import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:registration/model/players.dart';

import 'package:vijaychess/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Verify home page loads and shows About",
      (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    await firestore
        .collection('VCC-July')
        .withConverter<Player>(
            fromFirestore: (snapshot, _) =>
                Player.fromFireStore(snapshot.data()!),
            toFirestore: (player, _) => player.toJson())
        .add(Player(
            firstName: "Top",
            lastName: 'Seed',
            rating: 3200,
            status: 'Available',
            nwsrsId: 'B23422'));
    app.main();

    await tester.pumpAndSettle();

    await tester.tap(find.text('List all players'));

    await tester.pumpAndSettle();

    expect(find.text('Top'), findsOneWidget);
  });
}
