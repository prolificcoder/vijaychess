import 'package:flutter_test/flutter_test.dart';
import 'package:registration/model/events.dart';
import 'package:registration/model/players.dart';

void main() {
  test('Create event with one player', () {
    Player topSeed = Player(
        lastName: "Seed",
        firstName: "top",
        nwsrsId: "1",
        rating: 2342,
        status: "Ready");
    Event mainEvent = Event(
        name: "main",
        location: "Seattle",
        organizer: "SJ",
        eventDay: DateTime.now());
    mainEvent.players.add(topSeed);
    assert(mainEvent.players.length == 1);
  });
  test('Verify format from firestore for player', () {
    Player expected = Player(
        lastName: "Seed",
        firstName: "Top",
        nwsrsId: "1",
        rating: 2342,
        status: "Ready");

    var playerJson = {
      'first_name': 'Top',
      'last_name': 'Seed',
      'ID': '1',
      'rating': 2342,
      'status': 'Ready'
    };
    Player actual = Player.fromFireStore(playerJson);
    assert(expected.firstName == actual.firstName);
    assert(expected.lastName == actual.lastName);
    assert(expected.nwsrsId == actual.nwsrsId);
    assert(expected.rating == actual.rating);
    assert(expected.status == actual.status);
  });
}
