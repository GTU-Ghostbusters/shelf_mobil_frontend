import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/types/category.dart';

import '../types/enums.dart';

class GetBookPage extends StatefulWidget {
  const GetBookPage({super.key});

  @override
  State<GetBookPage> createState() => _GetBookPageState();
}

class _GetBookPageState extends State<GetBookPage> {
  static ViewType _viewType = ViewType.grid;
  static final List<String> _categoryList = Category.getCategoryNameList();
  static String? _selectedCategory = _categoryList.elementAt(0);

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
                    items: _categoryList
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
                  ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    )
                  : GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2.7,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
