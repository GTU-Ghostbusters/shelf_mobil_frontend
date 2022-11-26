import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
  List<Widget> pages = [ HomePage(), const GetBookPage(), const ShareBookPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: GNav(
        iconSize: 24,
        padding: const EdgeInsets.all(16),
        backgroundColor: const Color.fromARGB(20, 69, 69, 69),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        duration: const Duration(milliseconds: 200),
        gap: 10,
        tabBackgroundColor: const Color.fromARGB(30, 69, 69, 69),
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
        ],
        onTabChange: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        selectedIndex: _currentPage,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade400,
            ],
          ),
        ),
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
