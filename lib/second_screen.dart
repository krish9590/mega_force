import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return

// class SecondScreen extends StatelessWidget {
    // @override
    // Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.deepOrange,
        body: const Text('data'),
      ),
    );
  }
}
