import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class UserReceivedBooks extends StatefulWidget {
  const UserReceivedBooks({super.key});

  @override
  State<UserReceivedBooks> createState() => _UserReceivedBooksState();
}

class _UserReceivedBooksState extends State<UserReceivedBooks> {
  final List<Book> _receivedBooksList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDesign().createAppBar(
            "Received Books",
            BackButton(
              color: Colors.grey.shade900,
            ),
            []),
        body: Container(
          padding: const EdgeInsets.all(10),
          decoration: Background().getBackground(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Card(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _receivedBooksList.isEmpty
                              ? "0 book"
                              : _receivedBooksList.length == 1
                                  ? "1 book"
                                  : "${_receivedBooksList.length} books",
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 15),
                        ),
                      ]),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _receivedBooksList.length,
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
                              onTap: (() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return BookDetailPage(
                                          book: _receivedBooksList[index]);
                                    },
                                  ),
                                );
                              }),
                              child: Container(
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.68,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
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
                                          child: Image.network(
                                            _receivedBooksList[index].image1,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            _receivedBooksList[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                    0.02 +
                                                25,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        child: Text(
                                          _receivedBooksList[index].author,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        child: Text(
                                            _receivedBooksList[index]
                                                .donatorID
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ),
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
        ));
  }
}
