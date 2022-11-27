import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/get_book_page.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';
import 'package:shelf_mobil_frontend/pages/share_book_page.dart';

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
      theme: ThemeData(
        backgroundColor:
            createMaterialColor(const Color.fromARGB(151, 255, 0, 0)),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentPage = 0;
  final List<Widget> pages = [
    HomePage(),
    const GetBookPage(),
    const ShareBookPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(240, 45, 160, 232),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.05,
            color: const Color.fromARGB(240, 37, 37, 37),
          ),
        ),
        child: GNav(
          style: GnavStyle.oldSchool,
          padding: const EdgeInsets.all(2.5),
          tabMargin: const EdgeInsets.all(2.5),
          duration: const Duration(milliseconds: 300),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          iconSize: 27,
          textSize: 11,
          gap: 3,
          tabBorderRadius: 10,
          activeColor: const Color.fromARGB(240, 45, 160, 232),
          color: const Color.fromARGB(240, 37, 37, 37),
          tabs: const [
            GButton(
              icon: Icons.account_balance,
              text: "Home",
            ),
            GButton(
              icon: Icons.menu_book_outlined,
              text: "Get Book",
            ),
            GButton(
              icon: Icons.people_rounded,
              text: "Share Book",
            ),
            GButton(
              icon: Icons.account_box,
              text: "Account",
            ),
          ],
          onTabChange: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          selectedIndex: _currentPage,
        ),
      ),
      body: Container(
        child: pages[_currentPage],
      ),
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
