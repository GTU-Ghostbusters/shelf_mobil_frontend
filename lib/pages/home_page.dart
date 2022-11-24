import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categoryList = [
    Category(
        "WORLD CLASSICS",
        " ",
        "description"),
    Category(
        "NOVEL",
        " ",
        "description"),
    Category(
        "LITERATURE",
        " ",
        "description"),
    Category(
        "STORY",
        " ",
        "description"),
    Category(
        "SELF-HELP",
        " ",
        "description"),
    Category(
        "KIDS",
        " ",
        "description"),
    Category(
        "POLITICS",
        " ",
        "description"),
    Category(
        "POEM",
        " ",
        "description"),
    Category(
        "BIOGRAPHIES",
        " ",
        "description"),
    Category(
        "HISTORY",
        " ",
        "description"),
    Category(
        "ECONOMY",
        " ",
        "description"),
    Category(
        "ART",
        " ",
        "description"),
    Category(
        "EDUCATION",
        " ",
        "description"),
    Category(
        "SCIENCE-FICTION",
        " ",
        "description"),
    Category(
        "PHILOSOPHY-PSYCHOLOGY",
        " ",
        "description"),
    Category(
        "ENTERTAINMENT",
        " ",
        "description"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_add_rounded,
              color: Colors.black,),
            label: "",
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
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
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: categoryList.length,
              itemSize: 250,
              onItemFocus: (index) {},
              padding: const EdgeInsets.only(top: 10, bottom: 120),
              dynamicItemSize: true,
              updateOnScroll: true,
              scrollDirection: Axis.horizontal,
              dynamicItemOpacity: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Category category = categoryList[index];
    return SizedBox(
      width: 250,
      height: 150,
      child: Card(
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final String title;
  final String imagePath;
  final String description;

  Category(this.title, this.imagePath, this.description);
}
