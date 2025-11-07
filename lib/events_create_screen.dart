import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:registration/model/events.dart';

class EventsCreateScreen extends StatelessWidget {
  const EventsCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final eventsRef = FirebaseFirestore.instance
        .collection('events')
        .withConverter<Event>(
            fromFirestore: (snapshot, _) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, _) => event.toJson());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new event'),
      ),
      body: Column(children: [
        FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "name",
                  decoration: const InputDecoration(labelText: "Enter event name"),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                FormBuilderTextField(
                  name: "organizer",
                  decoration:
                      const InputDecoration(labelText: "Enter organizer name"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Organizer name is required')
                  ]),
                ),
                FormBuilderTextField(
                  name: "location",
                  decoration:
                      const InputDecoration(labelText: "Enter location of the event"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Location is required')
                  ]),
                ),
                FormBuilderDateTimePicker(
                  name: "eventDay",
                  inputType: InputType.date,
                  decoration:
                      const InputDecoration(labelText: "Enter event start date"),
                ),
              ],
            )),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.saveAndValidate()) {
              eventsRef.add(
                Event(
                    name: formKey.currentState!.value['name'],
                    organizer: formKey.currentState!.value['organizer'],
                    location: formKey.currentState!.value['location'],
                    eventDay: formKey.currentState!.value['eventDay']),
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
