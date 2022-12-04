import 'package:flutter/material.dart';

import 'login_page.dart';
import 'signup_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  static void changeLog() {
    _AccountPageState.isLogged
        ? _AccountPageState.isLogged = false
        : _AccountPageState.isLogged = true;
  }

  static bool isUserLogged() {
    return _AccountPageState.isLogged;
  }

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static bool isLogged = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            isLogged ? const Text("MY ACCOUNT") : const Text("USER MANAGEMENT"),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: [
                Color.fromARGB(60, 255, 131, 220),
                Color.fromARGB(60, 246, 238, 243),
                Color.fromARGB(60, 76, 185, 252),
              ],
            ),
          ),
          child: isLogged ? myAccount() : userManagement()),
    );
  }

  Widget myAccount() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          button(0.6, 50, 5, 18, null, "My Informations", (() {})),
          const SizedBox(height: 10),
          button(0.6, 50, 5, 18, null, "Favorites", (() {})),
          const SizedBox(height: 10),
          button(0.6, 50, 5, 18, null, "Uploaded Books", (() {})),
          const SizedBox(height: 10),
          button(0.6, 50, 5, 18, null, "Got Books", (() {})),
          const SizedBox(height: 10),
          button(0.25, 35, 5, 15, Colors.grey.shade600, "Log Out", () {
            setState(() {
              isLogged = false;
            });
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget userManagement() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          button(0.5, 40, 25, 16, null, "LOGIN", () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return const LoginPage();
              },
            ));
          }),
          const SizedBox(height: 5),
          button(0.5, 40, 25, 16, null, "SIGN UP", () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const SignUpPage();
                },
              ),
            );
          }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1)
        ],
      ),
    );
  }

  Widget button(double widthConst, double height, double radius,
      double fontSize, Color? color, String text, Function()? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width * widthConst, height),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w700)),
    );
  }
}
