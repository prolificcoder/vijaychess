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
}
