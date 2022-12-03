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
              Color.fromARGB(70, 255, 131, 220),
              Color.fromARGB(70, 246, 238, 243),
              Color.fromARGB(70, 76, 185, 252),
            ],
          ),
        ),
        child: isLogged
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    container(
                      50,
                      MediaQuery.of(context).size.width * 0.6,
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "My Informations",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    container(
                      50,
                      MediaQuery.of(context).size.width * 0.6,
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Favorites",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    container(
                      50,
                      MediaQuery.of(context).size.width * 0.6,
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Uploaded Books",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    container(
                      50,
                      MediaQuery.of(context).size.width * 0.6,
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Got Books",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade600),
                          fixedSize: MaterialStatePropertyAll(Size(
                              MediaQuery.of(context).size.width * 0.225, 35))),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.5, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.5, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const SignUpPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget container(double height, double width, Widget child) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          width: 0.2,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
