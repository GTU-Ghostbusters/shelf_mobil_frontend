import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class UserUploadedBooks extends StatefulWidget {
  const UserUploadedBooks({super.key});

  @override
  State<UserUploadedBooks> createState() => _UserUploadedBooksState();
}

class _UserUploadedBooksState extends State<UserUploadedBooks> {
  final List<Book> _uploadedBooksList = [];
  User _user = User.getWithID(userId: 0, name: "");
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await ApiService.getLoggedUser();
    _user = User.fromJsonID(jsonDecode(response.body));
    response = await ApiService.getAllBooks();
    var booksList = booksFromJson(response.body);
    for (var i = 0; i < booksList.length; i++) {
      if (booksList[i].donatorID == _user.userId) {
        _uploadedBooksList.add(booksList[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDesign().createAppBar(
            "Uploaded Books",
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
                          _uploadedBooksList.isEmpty
                              ? "Empty"
                              : _uploadedBooksList.length == 1
                                  ? "1 book"
                                  : "${_uploadedBooksList.length} books",
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 16),
                        ),
                      ]),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _uploadedBooksList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.68,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(width: 0.5),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Image.network(
                                              _uploadedBooksList[index]
                                                  .image1)),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.025,
                                      left: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          _uploadedBooksList[index].name,
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
                                      top: MediaQuery.of(context).size.height *
                                              0.025 +
                                          25,
                                      left: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        _uploadedBooksList[index].author,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var response = await ApiService.deleteBook(
                                    _uploadedBooksList[index].bookId);
                                setState(() {
                                  _uploadedBooksList.removeAt(index);
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
        ));
  }
}
