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
  List<Category> categoryList = Category.getCategoryList();
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
                      hintText: 'Search Book',
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
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: DropdownButton(
                    alignment: Alignment.topCenter,
                    isExpanded: true,elevation: 6,
                    icon: const Icon(Icons.category),
                    items: const [
                      DropdownMenuItem(
                          value: "Category1", child: Text("Category1"))
                    ],
                    onChanged: ((value) {}),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(200, 37, 37, 37),
                    ),
                  ),
                  child: IconButton(
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
            const Divider(),
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