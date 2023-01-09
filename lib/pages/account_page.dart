import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/my_info_page.dart';
import 'package:shelf_mobil_frontend/pages/my_reviews_page.dart';
import 'package:shelf_mobil_frontend/pages/user_received_books_page.dart';
import 'package:shelf_mobil_frontend/pages/user_uploaded_books_page.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';
import 'package:shelf_mobil_frontend/services/storage_service.dart';

import 'login_page.dart';
import 'signup_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  static void changeLog(String token) {
    _AccountPageState.token = token;
  }

  static bool isUserLogged() {
    return _AccountPageState.token != null;
  }

  static String? getToken() {
    return _AccountPageState.token;
  }

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static String? token;

  @override
  void initState() {
    super.initState();
    readFromStorage();
  }

  void readFromStorage() async {
    token = await StorageService.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
          AccountPage.isUserLogged() ? "MY ACCOUNT" : "USER MANAGEMENT",
          const SizedBox(), []),
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: Background().getBackground(),
          child: AccountPage.isUserLogged() ? myAccount() : userManagement()),
    );
  }

  Widget myAccount() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            button(0.6, 50, 5, 18, null, "My Informations", (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MyInfoPage();
                  },
                ),
              );
            })),
            const SizedBox(height: 10),
            button(0.6, 50, 5, 18, null, "My Reviews", (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MyReviewsPage();
                  },
                ),
              );
            })),
            const SizedBox(height: 10),
            button(0.6, 50, 5, 18, null, "Uploaded Books", (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const UserUploadedBooks();
                  },
                ),
              );
            })),
            const SizedBox(height: 10),
            button(0.6, 50, 5, 18, null, "Received Books", (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const UserReceivedBooks();
                  },
                ),
              );
            })),
            const SizedBox(height: 10),
            button(0.25, 35, 5, 15, Colors.grey.shade600, "Log Out", () {
              ApiService.logout();
              setState(() {
                StorageService.deleteToken();
                token = null;
              });
            }),
            const SizedBox(height: 20),
          ],
        ),
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

class SubPage extends StatefulWidget {
  SubPage({super.key, required this.title});
  String title;
  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      ),
    );
  }
}
