import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';

import '../types/category.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Category> categoryList = <Category>[
    Category("POLITICS", " ", "description", 32),
    Category("EDUCATION", " ", "description", 29),
    Category("LITERATURE", " ", "description", 23),
    Category("STORY", " ", "description", 21),
    Category("SCIENCE-FICTION", " ", "description", 15),
    Category("NOVEL", " ", "description", 14),
    Category("HISTORY", " ", "description", 8),
    Category("KIDS", " ", "description", 7),
    Category("BIOGRAPHIES", " ", "description", 6),
    Category("WORLD CLASSICS", " ", "description", 6),
    Category("ART", " ", "description", 5),
    Category("PHILOSOPHY", " ", "description", 5),
    Category("ECONOMY", " ", "description", 4),
    Category("SELF-HELP", " ", "description", 3),
    Category("ENTERTAINMENT", " ", "description", 1),
    Category("POEM", " ", "description", 0),
  ];

  void sortCategoryByNumberOfBooks() {
    categoryList.sort((a, b) => b.numberOfBooks.compareTo(a.numberOfBooks));
  }

  void sortCategoryByName() {
    categoryList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static CategorySort _categorySort = CategorySort.alphabetic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search Category',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18),
                      prefixIcon: Container(
                        width: 18,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          _categorySort == CategorySort.numberOfBooks
                              ? _categorySort = CategorySort.alphabetic
                              : _categorySort = CategorySort.numberOfBooks;
                          _categorySort == CategorySort.numberOfBooks
                              ? widget.sortCategoryByName()
                              : widget.sortCategoryByNumberOfBooks();
                        },
                      );
                    },
                    child: _categorySort == CategorySort.numberOfBooks
                        ? const Icon(Icons.sort_by_alpha)
                        : const Icon(Icons.sort),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            SizedBox(
              height: 480,
              child: ScrollSnapList(
                clipBehavior: Clip.none,
                itemBuilder: _buildListItem,
                itemCount: widget.categoryList.length,
                itemSize: 235,
                onItemFocus: (index) {},
                initialIndex: 0,
                dynamicItemSize: true,
                updateOnScroll: true,
                scrollDirection: Axis.horizontal,
                dynamicItemOpacity: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Category category = widget.categoryList[index];
    return SizedBox(
      width: 235,
      height: 170,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                category.title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                alignment: Alignment.center,
                "images/category_template.jpg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                category.numberOfBooks > 1 ? "${category.numberOfBooks} Books": category.numberOfBooks == 1 ? "1 Book": "No Book Found",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: category.numberOfBooks <= 0 ? const Text("") : ElevatedButton(
                onPressed: (() {}),
                child: category.numberOfBooks > 1 ? const Text("See Books") :const Text("See Book"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
