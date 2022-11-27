import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/types/category.dart';

import '../types/enums.dart';

class GetBookPage extends StatefulWidget {
  const GetBookPage({super.key});
  static final List<String> categoryNameList = Category.getCategoryNameList();
  @override
  State<GetBookPage> createState() => _GetBookPageState();
}

class _GetBookPageState extends State<GetBookPage> {
  static ViewType _viewType = ViewType.grid;
  static String? _selectedCategory = GetBookPage.categoryNameList.elementAt(0);

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
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    value: _selectedCategory,
                    items: GetBookPage.categoryNameList
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: ((item) {
                      setState(() {
                        _selectedCategory = item;
                      });
                    }),
                  ),
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
                        _viewType == ViewType.grid
                            ? _viewType = ViewType.list
                            : _viewType = ViewType.grid;
                        setState(
                          () {},
                        );
                      },
                      icon: _viewType == ViewType.grid
                          ? const Icon(Icons.grid_view_rounded)
                          : const Icon(Icons.list_alt_rounded),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: _viewType == ViewType.grid
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: _buildGridItem,
                      itemCount: 20,
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2.7,
                              mainAxisSpacing: 10),
                      itemBuilder: _buildListItem,
                      itemCount: 20,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(children: [
        FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.8,
          alignment: Alignment.topCenter,
          child: Image.asset(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            "images/category_template.jpg",
          ),
        ),
        const Positioned(
          bottom: 1,
          left: 60,
          child: Text(
              style: TextStyle(), 'Kitap Adı', textAlign: TextAlign.center),
        )
      ]),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(children: [
        Positioned(
          bottom: 15,
          left: 5,
          child: SizedBox(
            width: 70,
            child: Image.asset(
              fit: BoxFit.fill,
              alignment: Alignment.centerLeft,
              "images/category_template.jpg",
            ),
          ),
        ),
        const Positioned(
          bottom: 50,
          left: 200,
          child: Text(
              style: TextStyle(), 'Kitap Adı', textAlign: TextAlign.center),
        )
      ]),
    );
  }
}
