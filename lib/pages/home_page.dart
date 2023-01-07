import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shelf_mobil_frontend/pages/cart_page.dart';
import 'package:shelf_mobil_frontend/pages/favorites_page.dart';
import 'package:shelf_mobil_frontend/pages/search_page.dart';
import 'package:shelf_mobil_frontend/pages/share_book_page.dart';
import 'package:shelf_mobil_frontend/enums.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

import '../services/api_service.dart';
import '../models/category.dart';
import 'account_page.dart';
import 'get_book_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static List<Category>? getCategories() {
    _HomePageState._categoryList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return _HomePageState._categoryList;
  }
}

class _HomePageState extends State<HomePage> {
  static int _currentPageIndex = 0;
  static List<Category> _categoryList = [];
  CategorySort _categorySort = CategorySort.numberOfBooks;

  final List<Widget> pages = [
    const GetBookPage(),
    const FavoritesPage(),
    const ShareBookPage(),
    const AccountPage()
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData() async {
    Response response = await ApiService().getCategories();
    updateCategoryList(response);
    setState(() {});
  }

  void updateCategoryList(Response response) async {
    _categoryList = categoryFromJson(response.body);
    var count = 0;
    for (var category in _categoryList) {
      count += category.numberOfBooks;
    }
    _categoryList.add(Category(
        categoryID: 0,
        title: "ALL",
        imagePath:
            "https://img.freepik.com/free-photo/creative-world-book-day-assortment_23-2148883773.jpg?w=740&t=st=1672997298~exp=1672997898~hmac=58020f47b3729187a2f62027a4f51388be8289ea5076bd143c3adc0bf1bdb81f",
        numberOfBooks: count));
    _categoryList.sort(
      (a, b) {
        if (a.numberOfBooks == b.numberOfBooks) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        } else {
          return b.numberOfBooks.compareTo(a.numberOfBooks);
        }
      },
    );
  }

  void sortCategoryByNumberOfBooks() {
    _categoryList.sort(
      (a, b) {
        if (b.numberOfBooks == a.numberOfBooks) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        } else {
          return b.numberOfBooks.compareTo(a.numberOfBooks);
        }
      },
    );
  }

  void sortCategoryByName() {
    _categoryList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              icon: Icons.favorite_outlined,
              text: "Favorites",
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
            getData();
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDesign().createAppBar(
        "SHELF",
        IconButton(
          onPressed: () async {
            final Category? result = await showSearch<Category>(
              context: context,
              delegate: CategorySearchDelegate(categoryList: _categoryList),
            );
            if (_categoryList.contains(result)) {
              _currentPageIndex = 1;
              GetBookPage.setCategory(result!);
              setState(() {});
            }
          },
          icon: Icon(
            Icons.search_outlined,
            color: Colors.grey.shade900,
          ),
        ),
        [
          const CartButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined,
                color: Colors.grey.shade900),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    _categorySort == CategorySort.numberOfBooks
                        ? "Number of books"
                        : "Alphabetical",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(200, 37, 37, 37)),
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
                      icon: const Icon(Icons.sort, size: 20)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            cardView(_buildListItem),
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
          ],
        ),
      ),
    );
  }

  Widget cardView(var builder) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: ScrollSnapList(
        clipBehavior: Clip.none,
        itemBuilder: builder,
        itemCount: _categoryList.length,
        itemSize: MediaQuery.of(context).size.width * 0.6,
        onItemFocus: (index) {},
        initialIndex: 0,
        dynamicItemSize: true,
        updateOnScroll: true,
        scrollDirection: Axis.horizontal,
        dynamicItemOpacity: 0.95,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Category category = _categoryList[index];
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
              child: Image.network(fit: BoxFit.fitHeight, category.imagePath),
            ),
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
