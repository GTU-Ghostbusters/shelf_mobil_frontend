import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shelf_mobil_frontend/pages/cart.dart';
import 'package:shelf_mobil_frontend/pages/share_book_page.dart';
import 'package:shelf_mobil_frontend/enums.dart';

import '../services/api_service.dart';
import '../models/category.dart';
import 'account_page.dart';
import 'get_book_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static List<Category>? getCategories() {
    _HomePageState._categoryList!
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return _HomePageState._categoryList;
  }
}

class _HomePageState extends State<HomePage> {
  static List<Category>? _categoryList = [];

  static int _currentPageIndex = 0;

  CategorySort _categorySort = CategorySort.numberOfBooks;

  final List<Widget> pages = [
    const GetBookPage(),
    const ShareBookPage(),
    const AccountPage()
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _categoryList = (await ApiService().getCategories())!;
    _categoryList!.sort((a, b) => b.numberOfBooks.compareTo(a.numberOfBooks));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void sortCategoryByNumberOfBooks() {
    _categoryList!.sort((a, b) => b.numberOfBooks.compareTo(a.numberOfBooks));
  }

  void sortCategoryByName() {
    _categoryList!
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _currentPageIndex == 0
          ? AppBar(
              title: const Text("SHELF"),
              centerTitle: true,
              actions: const [CartButton()],
            )
          : null,
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
          activeColor: Theme.of(context).primaryColor,
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
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
        ),
      ),
      body: _currentPageIndex == 0 ? homePage() : pages[_currentPageIndex - 1],
    );
  }

  Widget homePage() {
    return Container(
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
      child: Column(children: [
        const SizedBox(height: 5),
        Row(children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search Category',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Container(
                    width: 18,
                    padding: const EdgeInsets.all(5),
                    child: const Icon(size: 20, Icons.search_rounded),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1.5, color: const Color.fromARGB(200, 37, 37, 37)),
            ),
            child: IconButton(
                color: const Color.fromARGB(230, 37, 37, 37),
                onPressed: () {
                  setState(() {
                    if (_categorySort == CategorySort.numberOfBooks) {
                      _categorySort = CategorySort.alphabetic;
                      sortCategoryByName();
                    } else {
                      _categorySort = CategorySort.numberOfBooks;
                      sortCategoryByNumberOfBooks();
                    }
                  });
                },
                icon: _categorySort == CategorySort.numberOfBooks
                    ? const Icon(Icons.sort)
                    : const Icon(Icons.sort_by_alpha)),
          )
        ]),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: ScrollSnapList(
            clipBehavior: Clip.none,
            itemBuilder: _buildListItem,
            itemCount: _categoryList!.length,
            itemSize: MediaQuery.of(context).size.width * 0.6,
            onItemFocus: (index) {},
            initialIndex: 0,
            dynamicItemSize: true,
            updateOnScroll: true,
            scrollDirection: Axis.horizontal,
            dynamicItemOpacity: 0.95,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              AccountPage.changeLog();
            });
          },
          style: ButtonStyle(
              backgroundColor: AccountPage.isUserLogged()
                  ? const MaterialStatePropertyAll(Colors.green)
                  : const MaterialStatePropertyAll(Colors.red)),
          child: const Text(
            "Change Log For Test",
          ),
        ),
      ]),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Category category = _categoryList![index];
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              category.title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.35,
                child:
                    Image.asset(fit: BoxFit.fitHeight, category.imagePath)),
            Column(children: [
              Text(
                  category.numberOfBooks > 1
                      ? "${category.numberOfBooks} Books"
                      : category.numberOfBooks == 1
                          ? "1 Book"
                          : "No Book Found",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  )),
              category.numberOfBooks <= 0
                  ? const Text("")
                  : TextButton(
                      onPressed: () {
                        _currentPageIndex = 1;
                        GetBookPage.setCategory(category);
                        setState(() {});
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(200, 37, 37, 37),
                        backgroundColor: const Color.fromARGB(50, 45, 160, 232),
                      ),
                      child: category.numberOfBooks > 1
                          ? const Text("See Books")
                          : const Text("See Book"),
                    ),
            ]),
          ],
        ),
      ),
    );
  }
}
