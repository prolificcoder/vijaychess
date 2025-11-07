import 'package:flutter/material.dart';

class ElevatedButtonWithPadding extends StatelessWidget {
  const ElevatedButtonWithPadding({super.key, required this.child});

  final ElevatedButton child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
