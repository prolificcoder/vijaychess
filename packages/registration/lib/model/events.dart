import 'package:registration/model/players.dart';

class Event {
  late final String name;
  late final String location;
  late final DateTime eventDay;
  //Might need eventEndDay
  late final String organizer; //could be entity with goggle account
  List<Player>
      players; //figure out a way to store this relationship in cloud store

  Event({
    required this.name,
    required this.location,
    required this.eventDay,
    required this.organizer,
  }) : players = [];

  Event.fromFireStore(Map<String, dynamic> json)
      : this(
            name: json['name']! as String,
            location: json['location']! as String,
            eventDay: json['eventDay'].toDate(),
            organizer: json['organizer'] as String);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'eventDay': eventDay,
      'organizer': organizer
    };
  }
}
