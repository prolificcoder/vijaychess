import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:registration/model/players.dart';

class PlayersCreateScreen extends StatelessWidget {
  PlayersCreateScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
        title: Text('Players'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: "first_name",
                decoration: InputDecoration(labelText: "Enter first name"),
              ),
              FormBuilderTextField(
                name: "last_name",
                decoration: InputDecoration(labelText: "Enter last name"),
              ),
              FormBuilderTextField(
                name: "rating",
                decoration: InputDecoration(labelText: "Enter current rating"),
              ),
              FormBuilderTextField(
                name: "status",
                decoration:
                    InputDecoration(labelText: "Enter status (available)"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    players.add(Player(
                        firstName: _formKey.currentState!.value['first_name'],
                        lastName: _formKey.currentState!.value['last_name'],
                        rating: _formKey.currentState!.value['rating'],
                        status: _formKey.currentState!.value['status'],
                        id: players.id));
                  }
                },
                child: const Text('Create'),
              ),
            ],
          )),
    );
  }
}
