import 'package:flutter/material.dart';

class ElevatedButtonWithPadding extends StatelessWidget {
  const ElevatedButtonWithPadding({Key? key, required this.child})
      : super(key: key);

  final ElevatedButton child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: child,
    );
  }
}
