import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/types/category.dart';

class GetBookPage extends StatefulWidget {
  const GetBookPage({super.key});
  static final List<String> categoryNameList = Category.getCategoryNameList();
  static final List<Category> categoryList =
      Category.getCategoryListAlphabeticSorted();
  @override
  State<GetBookPage> createState() => _GetBookPageState();
}

class _GetBookPageState extends State<GetBookPage> {
  static String _selectedCategory = GetBookPage.categoryNameList.elementAt(0);
  static int _selectedCategoryIndex = 0;

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
            Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = "ALL BOOKS";
                        _selectedCategoryIndex = 0;
                      });
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          GetBookPage.categoryNameList.elementAt(0) ==
                                  _selectedCategory
                              ? const MaterialStatePropertyAll(Colors.white)
                              : const MaterialStatePropertyAll(
                                  Color.fromARGB(200, 37, 37, 37),
                                ),
                      backgroundColor:
                          GetBookPage.categoryNameList.elementAt(0) ==
                                  _selectedCategory
                              ? const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 95, 186, 242))
                              : const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                    ),
                    child: const Text("ALL BOOKS"),
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Flexible(
                    flex: 1,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: GetBookPage.categoryNameList.length - 1,
                      itemBuilder: _buildCategoryItem,
                      separatorBuilder: ((context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
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
                const SizedBox(
                  width: 5,
                ),
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
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.sort)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Expanded(
              child: GetBookPage.categoryList
                          .elementAt(_selectedCategoryIndex)
                          .numberOfBooks >
                      0
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: _buildGridItem,
                      itemCount: GetBookPage.categoryList
                          .elementAt(_selectedCategoryIndex)
                          .numberOfBooks,
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
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedCategory = GetBookPage.categoryNameList.elementAt(index + 1);
          _selectedCategoryIndex = index + 1;
        });
      },
      style: ButtonStyle(
        foregroundColor: GetBookPage.categoryNameList.elementAt(index + 1) ==
                _selectedCategory
            ? const MaterialStatePropertyAll(Colors.white)
            : const MaterialStatePropertyAll(
                Color.fromARGB(200, 37, 37, 37),
              ),
        backgroundColor: GetBookPage.categoryNameList.elementAt(index + 1) ==
                _selectedCategory
            ? const MaterialStatePropertyAll(Color.fromARGB(255, 95, 186, 242))
            : const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
      child: Text(GetBookPage.categoryNameList.elementAt(index + 1)),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(20, 0, 0, 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.03),
              Container(
                height: constraints.maxHeight * 0.725,
                width: constraints.maxWidth * 0.8,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(220, 255, 255, 255),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey.shade500,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  "images/category_template.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              Container(
                height: constraints.maxHeight * 0.19,
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(220, 255, 255, 255),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey.shade500,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: constraints.maxHeight * 0.115,
                          width: constraints.maxWidth * 0.665,
                          child: Text(
                            "BOOK NAME",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.07,
                          width: constraints.maxWidth * 0.665,
                          child: Text(
                            "AUTHOR NAME",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
