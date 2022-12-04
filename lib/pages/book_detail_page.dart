import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/books.dart';
import 'package:shelf_mobil_frontend/pages/cart.dart';
import 'package:shelf_mobil_frontend/types/book.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int currentIndex = 0;
  static final List<String> images = Book.getImages();

  @override
  Widget build(BuildContext context) {
    getBookInformation();
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOOK NAME"),
        centerTitle: true,
        actions: const [CartButton()],
      ),
      body: FutureBuilder<List<Books>>(
        future: getBookInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("data"));
          } else if (snapshot.hasData) {
            List<Books> bookList = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(25),
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
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      container(
                        MediaQuery.of(context).size.height * 0.365,
                        MediaQuery.of(context).size.width * 0.8,
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              margin: const EdgeInsets.all(10),
                              child: PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    currentIndex = index % images.length;
                                  });
                                },
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SizedBox(
                                      child: Image.network(
                                        images[index % images.length]
                                            .toString(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < images.length; i++)
                                  buildIndicator(currentIndex == i)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextButton.icon(
                              style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(5),
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0.2,
                                            color: Colors.grey.shade800),
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text(
                                "Add to Shelf",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.41,
                            child: TextButton.icon(
                              style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(5),
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0.2,
                                            color: Colors.grey.shade800),
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border_rounded),
                              label: const Text(
                                "Add to Favorites",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      container(
                        MediaQuery.of(context).size.height * 0.15,
                        MediaQuery.of(context).size.width * 0.8,
                        Column(
                          children: [
                            informatonRow(
                                const Icon(Icons.menu_book_rounded),
                                bookList[0].name,
                                MediaQuery.of(context).size.height * 0.0365),
                            informatonRow(
                                const Icon(Icons.person),
                                bookList[0].author,
                                MediaQuery.of(context).size.height * 0.0365),
                            informatonRow(
                                const Icon(Icons.description),
                                "Number of Pages",
                                MediaQuery.of(context).size.height * 0.0365),
                            informatonRow(
                                const Icon(Icons.library_books),
                                bookList[0].category,
                                MediaQuery.of(context).size.height * 0.0365),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      container(
                        MediaQuery.of(context).size.height * 0.12,
                        MediaQuery.of(context).size.width * 0.8,
                        informatonRow(
                            const Icon(Icons.assured_workload),
                            "Information of Book",
                            MediaQuery.of(context).size.height * 0.12),
                      ),
                      const SizedBox(height: 5),
                      container(
                          MediaQuery.of(context).size.height * 0.05,
                          MediaQuery.of(context).size.width * 0.8,
                          informatonRow(
                              const Icon(Icons.local_shipping),
                              "Shipment Type",
                              MediaQuery.of(context).size.height * 0.05)),
                      const SizedBox(height: 15),
                      container(
                        50,
                        MediaQuery.of(context).size.width * 0.6,
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.account_circle,
                            size: 30,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "NAME OF BOOK OWNER",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text("data");
          }
        },
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  Widget informatonRow(Icon icon, String text, double height) {
    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: Row(
        children: [
          icon,
          const VerticalDivider(
            endIndent: 0,
            thickness: 1,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget container(double height, double width, Widget child) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(220, 255, 255, 255),
        border: Border.all(
          width: 0.2,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: height,
      width: width,
      child: child,
    );
  }

  Future<List<Books>> getBookInformation() async {
    String readingString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/books.json");

    var jsonObject = jsonDecode(readingString);
    List books = jsonObject;

    List<Books> allBooks =
        (jsonObject as List).map((bookMap) => Books.fromMap(bookMap)).toList();

    return allBooks;
  }
}
