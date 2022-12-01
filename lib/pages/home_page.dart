import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';

import '../types/category.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  List<Category> categoryList = Category.getCategoryListNumberOfBooksSorted();

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
            const SizedBox(height: 5),
            Row(
              children: [
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
                const SizedBox(width: 10),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1.5,
                      color: const Color.fromARGB(200, 37, 37, 37),
                    ),
                  ),
                  child: IconButton(
                    color: const Color.fromARGB(230, 37, 37, 37),
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
                    icon: _categorySort == CategorySort.numberOfBooks
                        ? const Icon(Icons.sort_by_alpha)
                        : const Icon(Icons.sort),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ScrollSnapList(
                clipBehavior: Clip.none,
                itemBuilder: _buildListItem,
                itemCount: widget.categoryList.length,
                itemSize: MediaQuery.of(context).size.width * 0.6,
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
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                "images/category_template.jpg",
              ),
            ),
            Column(
              children: [
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
                  ),
                ),
                category.numberOfBooks <= 0
                    ? const Text("")
                    : TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(200, 37, 37, 37),
                          backgroundColor:
                              const Color.fromARGB(40, 45, 160, 232),
                        ),
                        child: category.numberOfBooks > 1
                            ? const Text("See Books")
                            : const Text("See Book"),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
