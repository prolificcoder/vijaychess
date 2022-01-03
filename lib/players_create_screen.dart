import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
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
        title: Text('Add a new player'),
      ),
      body: Column(children: [
        FormBuilder(
            key: _formKey,
            autoFocusOnValidationFailure: true,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "first_name",
                  decoration: InputDecoration(labelText: "Enter first name"),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                ),
                FormBuilderTextField(
                  name: "last_name",
                  decoration: InputDecoration(labelText: "Enter last name"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: 'Last name is required')
                  ]),
                ),
                FormBuilderTextField(
                  name: "nwsrs_id",
                  decoration: InputDecoration(
                      labelText:
                          "Enter nwsrs id from http://chess.ratingsnw.com/ratings.html)"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.max(context, 8),
                  ]),
                ),
                FormBuilderTextField(
                    name: "rating",
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: "Enter current rating"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context,
                          errorText: 'Rating has to be numeric'),
                      FormBuilderValidators.maxLength(context, 4),
                    ])),
                FormBuilderTextField(
                  name: "status",
                  initialValue: "Available",
                  decoration: InputDecoration(
                      labelText: "Enter status to play tournaments"),
                ),
              ],
            )),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              players.add(
                Player(
                    firstName: _formKey.currentState!.value['first_name'],
                    lastName: _formKey.currentState!.value['last_name'],
                    rating: int.parse(_formKey.currentState!.value['rating']),
                    status: _formKey.currentState!.value['status'],
                    nwsrsId: _formKey.currentState!.value['nwsrs_id']),
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
      ]),
    );
  }
}
