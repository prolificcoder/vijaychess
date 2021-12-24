import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:registration/model/players.dart';
import 'package:vijaychess/firebase_options.dart';

class PlayersScreen extends StatefulWidget {
  PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  bool _initialized = false;
  bool _error = false;

  void initializedFlutterFire() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializedFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return ErrorWidget(_error);
    }
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    final players = FirebaseFirestore.instance
        .collection('VCC-July')
        .withConverter<Player>(
            fromFirestore: (snapshot, _) =>
                Player.fromFireStore(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson());

    return Scaffold(
        appBar: AppBar(
          title: Text('Players list'),
        ),
        body: FirestoreListView<Player>(
          query: players,
          itemBuilder: (context, snapshot) {
            Player player = snapshot.data();
            return Text('Player name is ${player.firstName}');
          },
        ));
  }
}
