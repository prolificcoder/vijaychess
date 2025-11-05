import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/events.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

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
          title: const Text('Events list'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Event>>(
                stream: eventsRef.orderBy('eventDay', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot<Event> document) {
                      Event event = document.data()!;
                      return ListTile(
                        title: Text(event.name),
                        subtitle: Text('${event.location}\n${event.organizer}'),
                        isThreeLine: true,
                        trailing:
                            Text(event.eventDay.toIso8601String().split('T').first),
                      );
                    }).toList(),
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
