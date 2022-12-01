import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(70, 121, 120, 121),
              Color.fromARGB(70, 246, 238, 243),
              Color.fromARGB(70, 76, 185, 252),
            ],
          ),
        ),
      ),
    );
  }
}
