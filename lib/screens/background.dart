import 'package:flutter/material.dart';

class Background {
  Decoration getBackground(){
    return const BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          colors: [
            Color.fromARGB(70, 255, 131, 220),
            Color.fromARGB(70, 246, 238, 243),
            Color.fromARGB(70, 76, 185, 252),
          ],
        ),
      );
  }
}