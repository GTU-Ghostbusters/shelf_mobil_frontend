import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';

void main() {
  runApp(const Shelf());
}

class Shelf extends StatelessWidget {
  const Shelf({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shelf',
      home: HomePage(),
    );
  }
}
