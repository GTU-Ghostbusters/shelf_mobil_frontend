import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/pages/cart.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';
import 'package:shelf_mobil_frontend/models/category.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("GET BOOK"),
          centerTitle: true,
          actions: const [CartButton()]),
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
        child: Column(children: [
          // CATEGORY BAR
          Container(
            padding: const EdgeInsets.all(5),
            height: 50,
            child: Row(children: [
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
                        maxLines: 1)),
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
            ]),
          ),
          const SizedBox(height: 5),

          // SEARCH BAR AND FILTER
          Row(children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 40,
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Search Book',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Container(
                      width: 18,
                      padding: const EdgeInsets.all(5),
                      child: const Icon(size: 20, Icons.search_rounded),
                    ),
                  ),
                ),
              ),
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
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.sort, size: 20,)))
          ]),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),

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
                : Text(
                    "NO BOOK FOUND",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
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
            child: Text(_categoryList!.elementAt(index).title),
          );
  }

  Widget _buildBookItem(BuildContext context, int index) {
    int indexCount = 0;
    for (var i = 1; i < _categoryList!.indexOf(_selectedCategory); i++) {
      indexCount += _categoryList![i].numberOfBooks;
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FutureBuilder<List<Book>>(
          future: getBookInformation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ERROR");
            } else if (snapshot.hasData) {
              List<Book> bookList = snapshot.data!;

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
                                return BookDetailPage(
                                    book: bookList[index + indexCount]);
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
                              bookList[index + indexCount].image,
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
                                  bookList[index + indexCount].shipmentType,
                                  style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w700),
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
                                  Text(bookList[index + indexCount].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                  Text(bookList[index + indexCount].author,
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
                                  onPressed: () {},
                                  icon: const Icon(
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

  Future<List<Book>> getBookInformation() async {
    String readingString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/books.json");

    var jsonObject = jsonDecode(readingString);

    List<Book> allBooks =
        (jsonObject as List).map((bookMap) => Book.fromJson(bookMap)).toList();
    allBooks.sort(
        (a, b) => a.category.toLowerCase().compareTo(b.category.toLowerCase()));
    return allBooks;
  }
}
