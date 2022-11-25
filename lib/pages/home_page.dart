import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../datas/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categoryList = Category.getCategoryList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: TextField(
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
                    child: const Icon(Icons.search_rounded),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Expanded(
              child: ScrollSnapList(
                itemBuilder: _buildListItem,
                itemCount: categoryList.length,
                itemSize: 235,
                onItemFocus: (index) {},
                padding: const EdgeInsets.only(top: 10, bottom: 100),
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
    Category category = categoryList[index];
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
