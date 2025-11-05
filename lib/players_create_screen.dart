import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/players.dart';
import 'package:vijaychess/elevated_button_with_padding_widget.dart';

class PlayersCreateScreen extends StatelessWidget {
  const PlayersCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final players = FirebaseFirestore.instance
        .collection('VCC-July')
        .withConverter<Player>(
            fromFirestore: (snapshot, _) =>
                Player.fromFireStore(snapshot.data()!),
            toFirestore: (player, _) => player.toJson());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new player'),
      ),
      body: Column(children: [
        FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "first_name",
                  decoration: const InputDecoration(labelText: "Enter first name"),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                FormBuilderTextField(
                  name: "last_name",
                  decoration: const InputDecoration(labelText: "Enter last name"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Last name is required')
                  ]),
                ),
                FormBuilderTextField(
                  name: "nwsrs_id",
                  decoration: const InputDecoration(
                      labelText:
                          "Enter nwsrs id from http://chess.ratingsnw.com/ratings.html)"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(8),
                  ]),
                ),
                FormBuilderTextField(
                    name: "rating",
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: "Enter current rating"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(
                          errorText: 'Rating has to be numeric'),
                      FormBuilderValidators.maxLength(4),
                    ])),
                FormBuilderTextField(
                  name: "status",
                  initialValue: "Available",
                  decoration: const InputDecoration(
                      labelText: "Enter status to play tournaments"),
                ),
              ],
            )),
        ElevatedButtonWithPadding(
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.saveAndValidate()) {
                players.add(
                  Player(
                      firstName: formKey.currentState!.value['first_name'],
                      lastName: formKey.currentState!.value['last_name'],
                      rating: int.parse(formKey.currentState!.value['rating']),
                      status: formKey.currentState!.value['status'],
                      nwsrsId: formKey.currentState!.value['nwsrs_id']),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Player created')),
                );
                context.pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error creating player, try again')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ),
      ]),
    );
  }
}
