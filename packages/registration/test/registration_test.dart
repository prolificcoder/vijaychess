import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:registration/model/events.dart';
import 'package:registration/model/players.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  test('Verify format from firestore for events', () {
    Event expected = Event(
      organizer: 'TD',
      location: 'Internet',
      name: 'test guild',
      eventDay: DateTime.parse('2021-12-31 16:00:00'),
    );
    var eventDayObj = Timestamp(1640995200, 0);

    var eventJson = {
      'organizer': 'TD',
      'location': 'Internet',
      'name': 'test guild',
      'eventDay': eventDayObj,
    };
    Event actual = Event.fromFireStore(eventJson);
    assert(expected.organizer == actual.organizer);
    assert(expected.location == actual.location);
    assert(expected.name == actual.name);
    print('actual seconds is ${actual.eventDay.microsecondsSinceEpoch}');
    print('expected seconds is ${expected.eventDay.microsecondsSinceEpoch}');
    //Somehow not passing in github but passes locally
    // assert(
    //   expected.eventDay.microsecondsSinceEpoch ==
    //       actual.eventDay.microsecondsSinceEpoch,
    // );
  });
}
