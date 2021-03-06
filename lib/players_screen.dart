import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/players.dart';

class PlayersScreen extends StatelessWidget {
  PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final players = FirebaseFirestore.instance
        .collection('VCC-July')
        .withConverter<Player>(
            fromFirestore: (snapshot, _) =>
                Player.fromFireStore(snapshot.data()!),
            toFirestore: (player, _) => player.toJson());

    return Scaffold(
        appBar: AppBar(
          title: Text('Players list'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: FirestoreListView<Player>(
                query: players.orderBy('first_name'),
                itemBuilder: (context, snapshot) {
                  Player player = snapshot.data();
                  return ListTile(
                    title: Text('${player.firstName} ${player.lastName}'),
                    subtitle:
                        Text('${player.rating.toString()}\n${player.nwsrsId}'),
                    isThreeLine: true,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/players/new');
              },
              child: const Text('Create new player'),
            ),
          ]),
        ));
  }
}
