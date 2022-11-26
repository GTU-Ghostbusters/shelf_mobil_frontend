import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';

import '../types/category.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Category> categoryList = <Category>[
    Category("WORLD CLASSICS", " ", "description", 6),
    Category("NOVEL", " ", "description", 14),
    Category("LITERATURE", " ", "description", 23),
    Category("STORY", " ", "description", 21),
    Category("SELF-HELP", " ", "description", 3),
    Category("KIDS", " ", "description", 7),
    Category("POLITICS", " ", "description", 32),
    Category("POEM", " ", "description", 2),
    Category("BIOGRAPHIES", " ", "description", 6),
    Category("HISTORY", " ", "description", 8),
    Category("ECONOMY", " ", "description", 4),
    Category("ART", " ", "description", 5),
    Category("EDUCATION", " ", "description", 29),
    Category("SCIENCE-FICTION", " ", "description", 15),
    Category("PHILOSOPHY", " ", "description", 5),
    Category("ENTERTAINMENT", " ", "description", 3)
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sortCategoryByNumberOfBooks() {
    widget.categoryList
        .sort((a, b) => b.numberOfBooks.compareTo(a.numberOfBooks));
  }

  void sortCategoryByName() {
    widget.categoryList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  CategorySort _categorySort = CategorySort.numberOfBooks;

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
                      setState(() {
                        _categorySort == CategorySort.numberOfBooks
                            ? _categorySort = CategorySort.alphabetic
                            : _categorySort = CategorySort.numberOfBooks;
                        _categorySort == CategorySort.numberOfBooks
                            ? sortCategoryByName()
                            : sortCategoryByNumberOfBooks();
                      });
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
            SizedBox(
              height: 500,
              child: ScrollSnapList(
                clipBehavior: Clip.none,
                itemBuilder: _buildListItem,
                itemCount: widget.categoryList.length,
                itemSize: 235,
                onItemFocus: (index) {},
                dynamicItemSize: true,
                updateOnScroll: true,
                scrollDirection: Axis.horizontal,
                dynamicItemOpacity: 0.9,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              category.title,
              style: const TextStyle(fontSize: 20),
            ),
            Image.asset(
              "images/category_template.jpg",
            ),
            const Text(
              "description of category",
            ),
            ElevatedButton(
              onPressed: (() {}),
              child: const Text("See Books"),
            ),
          ],
        ),
      ),
    );
  }
}
