import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/players.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

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
          title: const Text('Players list'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Player>>(
                stream: players.orderBy('first_name').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot<Player> document) {
                      Player player = document.data()!;
                      return ListTile(
                        title: Text('${player.firstName} ${player.lastName}'),
                        subtitle:
                            Text('${player.rating.toString()}\n${player.nwsrsId}'),
                        isThreeLine: true,
                      );
                    }).toList(),
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
