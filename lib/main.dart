import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shelf'),
        ),
        body: const Center(child: Text('Welcome to Shelf')),
      ),
    );
  }
}
