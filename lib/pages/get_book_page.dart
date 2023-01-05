import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/pages/cart_page.dart';
import 'package:shelf_mobil_frontend/pages/favorites_page.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';
import 'package:shelf_mobil_frontend/models/category.dart';
import 'package:shelf_mobil_frontend/pages/search_page.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/screens/filter_drawer.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

import '../models/book.dart';

class GetBookPage extends StatefulWidget {
  const GetBookPage({super.key});

  @override
  State<GetBookPage> createState() => _GetBookPageState();

  static void setCategory(Category category) {
    _GetBookPageState._selectedCategory = category;
  }
}

class _GetBookPageState extends State<GetBookPage> {
  final List<Category>? _categoryList = HomePage.getCategories();
  static Category _selectedCategory = HomePage.getCategories()!.first;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
        "GET BOOK",
        const BookSearchButton(),
        [
          const CartButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined,
                color: Colors.grey.shade900),
          )
        ],
      ),
      key: _scaffoldKey,
      endDrawer: const FilterDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: Column(children: [
          // CATEGORY BAR
          Container(
            padding: const EdgeInsets.only(left: 5),
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = _categoryList!.first;
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        _selectedCategory.title,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 13),
                      )),
                ),
                const VerticalDivider(
                    width: 10, thickness: 1, indent: 0, endIndent: 0),
                Flexible(
                  flex: 1,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryList!.length,
                      itemBuilder: _buildCategoryItem,
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                            width: _selectedCategory.title ==
                                        _categoryList!.elementAt(index).title ||
                                    _categoryList!.elementAt(index).title ==
                                        _categoryList!.elementAt(0).title
                                ? 0
                                : 5);
                      })),
                ),
                const SizedBox(width: 5),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1.5,
                      color: const Color.fromARGB(200, 37, 37, 37),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.filter_alt,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          // BOOKS
          Flexible(
            child: _selectedCategory.numberOfBooks > 0
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.82,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: _buildBookItem,
                    itemCount: _selectedCategory.numberOfBooks,
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "NO BOOK FOUND",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    return _selectedCategory.title == _categoryList!.elementAt(index).title ||
            _categoryList!.elementAt(index).title ==
                _categoryList!.elementAt(0).title
        ? const SizedBox()
        : OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = _categoryList!.elementAt(index);
              });
            },
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(200, 37, 37, 37)),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
            ),
            child: Text(
              _categoryList!.elementAt(index).title,
              style: const TextStyle(fontSize: 13),
            ),
          );
  }

  Widget _buildBookItem(BuildContext context, int index) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FutureBuilder<Response>(
          future: ApiService().getBooksWithCategory(_selectedCategory.title),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ERROR");
            } else if (snapshot.hasData) {
              List<Book> bookList = booksFromJson(snapshot.data!.body);
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(3, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {
                    AccountPage.isUserLogged() == false
                        ? showDialog(
                            context: context,
                            builder: (context) => const AlertDialogUserCheck(
                              subText:
                                  "You should login to view or get a book.",
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return BookDetailPage(book: bookList[index]);
                              },
                            ),
                          );
                  },
                  child: Column(children: [
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.6,
                            width: constraints.maxWidth * 0.75,
                            padding: const EdgeInsets.all(5),
                            child: Image.network(
                              bookList[index].image1,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.1,
                            width: constraints.maxWidth * 0.75,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(150, 232, 232, 232),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.local_shipping,
                                    size: 20, color: Colors.grey.shade900),
                                const SizedBox(width: 10),
                                Text(
                                  textAlign: TextAlign.center,
                                  bookList[index].shipmentType,
                                  style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: constraints.maxHeight * 0.19,
                        width: constraints.maxWidth * 0.9,
                        child: Stack(children: [
                          Positioned(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: constraints.maxHeight * 0.185,
                              width: constraints.maxWidth * 0.7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(bookList[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                  Text(bookList[index].author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 11,
                                      ),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 6,
                            child: SizedBox(
                              height: constraints.maxWidth * 0.19,
                              width: constraints.maxWidth * 0.2,
                              child: IconButton(
                                  onPressed: () {
                                    AccountPage.isUserLogged() == false
                                        ? showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialogUserCheck(
                                              subText:
                                                  "You should login to add a book to favorites.",
                                            ),
                                          )
                                        : setState(() {
                                            if (FavoritesPage.isAddedToFav(
                                                bookList[index])) {
                                              FavoritesPage.removeFromFav(
                                                  bookList[index]);
                                            } else {
                                              FavoritesPage.addToFav(
                                                  bookList[index]);
                                            }
                                          });
                                  },
                                  icon: FavoritesPage.isAddedToFav(
                                          bookList[index])
                                      ? const Icon(Icons.favorite_outlined,
                                          color: Colors.red)
                                      : const Icon(
                                          Icons.favorite_outline_outlined)),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ]),
                ),
              );
            } else {
              return const Text("");
            }
          });
    });
  }
}
