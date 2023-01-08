import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static void addToFav(int bookId) {
    favBooksId.add(bookId);
  }

  static void removeFromFav(int bookId) {
    favBooksId.remove(bookId);
  }

  static bool isAddedToFav(int bookId) {
    return favBooksId.contains(bookId);
  }

  static final List<int> favBooksId = [];

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  /*  Future<Response> getFavBookDetail() async {
    Response response1 = await ApiService.getFavorities();
    Map<String, dynamic> res = jsonDecode(response1.body);
    Response response2 = await ApiService.getBookDetail(res["book_id"]);
    debugPrint(response2.body.toString());
    return response2;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar("FAVORITES", const SizedBox(), []),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: AccountPage.isUserLogged() == false
            ? const Center(
                child: AlertDialogUserCheck(
                    subText: "You should login to see favorites."))
            : Column(
                children: [
                  Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 45),
                          Text(
                            FavoritesPage.favBooksId.isEmpty
                                ? "Empty"
                                : FavoritesPage.favBooksId.length == 1
                                    ? "1 book"
                                    : "${FavoritesPage.favBooksId.length} books",
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 15),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                FavoritesPage.favBooksId.clear();
                              });
                            },
                            icon: Icon(Icons.delete_sweep_outlined,
                                color: Colors.grey.shade600),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: FavoritesPage.favBooksId.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  /* onTap: (() {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return BookDetailPage(
                                              book: FavoritesPage
                                                  .favBooksId[index]);
                                        },
                                      ),
                                    );
                                  }), */
                                  child: Container(
                                    color: Colors.transparent,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.68,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 0.5),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.125,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              /* child: Image.network(
                                                FavoritesPage
                                                    .favBooksId[index].image1,
                                              ), */
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.24,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                "a",
                                                /* FavoritesPage
                                                    .favBooksId[index].name, */
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          /* Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02 +
                                                25,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.24,
                                            child: Text(
                                              FavoritesPage
                                                  .favBooksId[index].author,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ), */
                                          /* Positioned(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.24,
                                            child: Text(
                                                FavoritesPage
                                                    .favBooksId[index].donatorID
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                textAlign: TextAlign.center),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      FavoritesPage.favBooksId.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
