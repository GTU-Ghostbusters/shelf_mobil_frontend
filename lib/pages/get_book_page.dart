import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/pages/cart.dart';
import 'package:shelf_mobil_frontend/types/category.dart';

import '../types/book.dart';

class GetBookPage extends StatefulWidget {
  const GetBookPage({super.key});
  static final List<Category> categoryList =
      Category.getCategoryListAlphabeticSorted();
  static void setCategory(Category category) {
    category.title == "ALL"
        ? _GetBookPageState._selectedCategory = categoryList.first
        : _GetBookPageState._selectedCategory = category;
  }

  @override
  State<GetBookPage> createState() => _GetBookPageState();
}

class _GetBookPageState extends State<GetBookPage> {
  static Category _selectedCategory = GetBookPage.categoryList.elementAt(0);

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
          Container(
            padding: const EdgeInsets.all(5),
            height: 50,
            child: Row(children: [
              SizedBox(
                height: 40,
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = GetBookPage.categoryList.first;
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
                    itemCount: GetBookPage.categoryList.length,
                    itemBuilder: _buildCategoryItem,
                    separatorBuilder: ((context, index) {
                      return SizedBox(
                          width: _selectedCategory.title ==
                                      GetBookPage.categoryList
                                          .elementAt(index)
                                          .title ||
                                  GetBookPage.categoryList
                                          .elementAt(index)
                                          .title ==
                                      GetBookPage.categoryList
                                          .elementAt(0)
                                          .title
                              ? 0
                              : 5);
                    })),
              ),
            ]),
          ),
          const SizedBox(height: 5),
          Row(children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 45,
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
                height: 43,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.5,
                    color: const Color.fromARGB(200, 37, 37, 37),
                  ),
                ),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.sort)))
          ]),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          Flexible(
            child: _selectedCategory.numberOfBooks > 0
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: _buildGridItem,
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
    return _selectedCategory.title ==
                GetBookPage.categoryList.elementAt(index).title ||
            GetBookPage.categoryList.elementAt(index).title ==
                GetBookPage.categoryList.elementAt(0).title
        ? const SizedBox()
        : OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = GetBookPage.categoryList.elementAt(index);
              });
            },
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(200, 37, 37, 37)),
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
            ),
            child: Text(GetBookPage.categoryList.elementAt(index).title),
          );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    int indexCount = 0;
    for (var i = 1;
        i < GetBookPage.categoryList.indexOf(_selectedCategory);
        i++) {
      indexCount += GetBookPage.categoryList[i].numberOfBooks;
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FutureBuilder<List<Books>>(
          future: getBookInformation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ERROR");
            } else if (snapshot.hasData) {
              List<Books> bookList = snapshot.data!;

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(5, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  GestureDetector(
                    onTap: () {
                      AccountPage.isUserLogged() == false
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: (() {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return const AccountPage();
                                            },
                                          ),
                                        );
                                      }),
                                      child: const Text(
                                        "USER PAGE",
                                        style: TextStyle(fontSize: 18),
                                      ))
                                ],
                                title: const Text("USER LOGIN NEED"),
                                contentPadding: const EdgeInsets.all(20),
                                actionsAlignment: MainAxisAlignment.center,
                                content: const Text(
                                    "You should login to view or get a book."),
                              ),
                            )
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return BookDetailPage(
                                      name: bookList[index + indexCount].name,
                                      author:
                                          bookList[index + indexCount].author,
                                      pages: bookList[index + indexCount]
                                          .numberOfBooks,
                                      category:
                                          bookList[index + indexCount].category,
                                      image: bookList[index + indexCount].image,
                                      details: bookList[index + indexCount]
                                          .bookAbstract,
                                      owner:
                                          bookList[index + indexCount].donator,
                                      shipment: bookList[index + indexCount]
                                          .shipmentType);
                                },
                              ),
                            );
                    },
                    child: Container(
                      height: constraints.maxHeight * 0.725,
                      width: constraints.maxWidth * 0.8,
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        border:
                            Border.all(width: 0.5, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.network(
                        bookList[index + indexCount].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Container(
                    height: constraints.maxHeight * 0.19,
                    width: constraints.maxWidth * 0.91,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        border:
                            Border.all(width: 0.5, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(children: [
                      Column(children: [
                        Container(
                          alignment: Alignment.center,
                          height: constraints.maxHeight * 0.115,
                          width: constraints.maxWidth * 0.675,
                          child: Text(bookList[index + indexCount].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.07,
                          width: constraints.maxWidth * 0.675,
                          child: Text(bookList[index + indexCount].author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ]),
                      Container(
                        color: Colors.grey.shade400,
                        width: constraints.maxWidth * 0.004,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.22,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_outline_outlined)),
                      )
                    ]),
                  ),
                ]),
              );
            } else {
              return const Text("");
            }
          });
    });
  }

  Future<List<Books>> getBookInformation() async {
    String readingString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/books.json");

    var jsonObject = jsonDecode(readingString);

    List<Books> allBooks =
        (jsonObject as List).map((bookMap) => Books.fromMap(bookMap)).toList();
    allBooks.sort(
        (a, b) => a.category.toLowerCase().compareTo(b.category.toLowerCase()));
    return allBooks;
  }
}
