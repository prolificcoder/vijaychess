import 'package:registration/model/players.dart';

class Event {
  late final String name;
  late final String location;
  late final DateTime eventTime;
  late final String organizer;
  List<Player> players;

  Event({
    required this.name,
    required this.location,
    required this.eventTime,
    required this.organizer,
  }) : players = [];

}