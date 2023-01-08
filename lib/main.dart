import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';
// ignore: unused_import
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(const Shelf());
}

class Shelf extends StatelessWidget {
  const Shelf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shelf',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }

}


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
