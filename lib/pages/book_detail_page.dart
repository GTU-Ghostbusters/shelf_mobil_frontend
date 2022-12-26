import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/cart.dart';

import '../models/book.dart';
import 'account_page.dart';

class BookDetailPage extends StatefulWidget {
  BookDetailPage({
    super.key,
    required this.book,
  });
  late Book book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name),
        centerTitle: true,
        actions: const [CartButton()],
      ),
      body: Container(
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
                              currentIndex = index % 3;
                            });
                          },
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                child: Image.network(
                                  widget.book.image,
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
                          for (var i = 0; i < 3; i++)
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
                      width: MediaQuery.of(context).size.width * 0.34,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(5),
                          foregroundColor:
                              const MaterialStatePropertyAll(Colors.white),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.2, color: Colors.grey.shade800),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text(
                          "Add to Cart",
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
                          foregroundColor:
                              const MaterialStatePropertyAll(Colors.white),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.2, color: Colors.grey.shade800),
                                  borderRadius: BorderRadius.circular(5))),
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
                          const Icon(Icons.menu_book),
                          widget.book.name,
                          MediaQuery.of(context).size.height * 0.0365),
                      informatonRow(
                          const Icon(Icons.person),
                          widget.book.author,
                          MediaQuery.of(context).size.height * 0.0365),
                      informatonRow(
                          const Icon(Icons.numbers),
                          widget.book.numberOfPages.toString(),
                          MediaQuery.of(context).size.height * 0.0365),
                      informatonRow(
                          const Icon(Icons.type_specimen),
                          widget.book.category,
                          MediaQuery.of(context).size.height * 0.0365),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                container(
                  MediaQuery.of(context).size.height * 0.12,
                  MediaQuery.of(context).size.width * 0.8,
                  informatonRow(
                      const Icon(Icons.text_snippet_rounded),
                      widget.book.bookAbstract,
                      MediaQuery.of(context).size.height * 0.12),
                ),
                const SizedBox(height: 5),
                container(
                    MediaQuery.of(context).size.height * 0.05,
                    MediaQuery.of(context).size.width * 0.8,
                    informatonRow(
                        const Icon(Icons.local_shipping),
                        widget.book.shipmentType,
                        MediaQuery.of(context).size.height * 0.05)),
                const SizedBox(height: 15),
                container(
                  50,
                  MediaQuery.of(context).size.width * 0.6,
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SubPage(title: widget.book.donator);
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.black,
                    ),
                    label: Text(
                      widget.book.donator,
                      style: const TextStyle(
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
}
