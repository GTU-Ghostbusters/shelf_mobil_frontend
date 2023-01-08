import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/pages/cart_page.dart';
import 'package:shelf_mobil_frontend/pages/favorites_page.dart';
import 'package:shelf_mobil_frontend/pages/user_review_page.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

import '../models/book.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    super.key,
    required this.book,
  });
  final Book book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int currentIndex = 0;
  User? _user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    var response = await ApiService.getUser(widget.book.donatorID);
    User user = User.fromJson(jsonDecode(response.body));
    _user = user;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(widget.book.name,
          BackButton(color: Colors.grey.shade900), [const CartButton()]),
      body: Container(
        padding: const EdgeInsets.all(25),
        decoration: Background().getBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // IMAGES
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
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            if (index == 0) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  child: Image.network(
                                    widget.book.image1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            } else if (index == 1) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  child: Image.network(
                                    widget.book.image2,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  child: Image.network(
                                    widget.book.image3,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }
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

                // BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton.icon(
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
                        onPressed: () {
                          if (CartPage.isAddedToCart(widget.book)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 1000),
                                content: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: Text(
                                    "${widget.book.name} is already added to cart",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    const Color.fromARGB(240, 255, 77, 77),
                              ),
                            );
                          } else {
                            CartPage.addToCart(widget.book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 1000),
                                content: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: Text(
                                    "${widget.book.name} is added to cart",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    const Color.fromARGB(240, 33, 149, 243),
                              ),
                            );
                          }
                        },
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
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ElevatedButton.icon(
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
                        onPressed: () {
                          if (FavoritesPage.isAddedToFav(widget.book)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 1000),
                                content: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: Text(
                                    "${widget.book.name} is already added to favorites",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    const Color.fromARGB(240, 255, 77, 77),
                              ),
                            );
                          } else {
                            FavoritesPage.addToFav(widget.book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 1000),
                                content: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child: Text(
                                    "${widget.book.name} is added to favorites",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    const Color.fromARGB(240, 33, 149, 243),
                              ),
                            );
                          }
                        },
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

                // INFORMATION ROW1
                container(
                  MediaQuery.of(context).size.height * 0.145,
                  MediaQuery.of(context).size.width * 0.8,
                  Column(
                    children: [
                      informatonRow(
                          const Icon(Icons.menu_book),
                          widget.book.name,
                          MediaQuery.of(context).size.height * 0.035),
                      informatonRow(
                          const Icon(Icons.person),
                          widget.book.author,
                          MediaQuery.of(context).size.height * 0.035),
                      informatonRow(
                          const Icon(Icons.numbers),
                          widget.book.numberOfPages.toString(),
                          MediaQuery.of(context).size.height * 0.035),
                      informatonRow(
                          const Icon(Icons.type_specimen),
                          widget.book.category,
                          MediaQuery.of(context).size.height * 0.035),
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
                            return UserReviewPage(
                                user: _user!);
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
                      (_user != null) ? _user!.name : "",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const VerticalDivider(
            endIndent: 0,
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            width: MediaQuery.of(context).size.width * 0.6,
            child: SingleChildScrollView(
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }

  Widget container(double height, double width, Widget child) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
