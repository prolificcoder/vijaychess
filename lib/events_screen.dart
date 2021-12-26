import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/events.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsRef = FirebaseFirestore.instance
        .collection('events')
        .withConverter<Event>(
            fromFirestore: (snapshot, _) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, _) => event.toJson());
    return Scaffold(
        appBar: AppBar(
          title: Text('Events list'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: FirestoreListView<Event>(
                query: eventsRef.orderBy('eventDay', descending: true),
                itemBuilder: (context, snapshot) {
                  Event event = snapshot.data();
                  return ListTile(
                    title: Text(event.name),
                    subtitle: Text('${event.location}\n${event.organizer}'),
                    isThreeLine: true,
                    trailing: Text(event.eventDay
                        .toIso8601String()
                        .split('T')
                        .first
                        .toString()),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/events/new');
              },
              child: const Text('Create new event'),
            ),
          ]),
        ));
  }
}
