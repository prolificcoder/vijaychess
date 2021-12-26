import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/events.dart';

class EventsCreateScreen extends StatelessWidget {
  EventsCreateScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
        title: Text('Add a new event'),
      ),
      body: Column(children: [
        FormBuilder(
            key: _formKey,
            autoFocusOnValidationFailure: true,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "name",
                  decoration: InputDecoration(labelText: "Enter event name"),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                ),
                FormBuilderTextField(
                  name: "organizer",
                  decoration:
                      InputDecoration(labelText: "Enter organizer name"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: 'Organizer name is required')
                  ]),
                ),
                FormBuilderTextField(
                  name: "location",
                  decoration:
                      InputDecoration(labelText: "Enter location of the event"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: 'Location is required')
                  ]),
                ),
                FormBuilderDateTimePicker(
                  name: "eventDay",
                  inputType: InputType.date,
                  decoration:
                      InputDecoration(labelText: "Enter event start date"),
                ),
              ],
            )),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              eventsRef.add(
                Event(
                    name: _formKey.currentState!.value['name'],
                    organizer: _formKey.currentState!.value['organizer'],
                    location: _formKey.currentState!.value['location'],
                    eventDay: _formKey.currentState!.value['eventDay']),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event created')),
              );
              context.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Error creating event, try again')),
              );
            }
          },
          child: const Text('Create event'),
        ),
      ]),
    );
  }
}
