import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/category.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class BookSearchButton extends StatelessWidget {
  const BookSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: BookSearchDelegate(),
        );
      },
      icon: Icon(Icons.search_outlined, color: Colors.grey.shade900),
    );
  }
}

class BookSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search Book';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Response>(
      future: ApiService().getAllBooks(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Book> bookList = booksFromJson(data!.body);
        List<Book> matchQuery = [];
        for (var i = 0; i < bookList.length; i++) {
          if (bookList[i].name.toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(bookList[i]);
          }
        }
        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var item = matchQuery[index];
            return _buildListItem(context, item);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<Response>(
      future: ApiService().getAllBooks(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Book> bookList = booksFromJson(data!.body);

        return ListView.builder(
          itemCount: bookList.length,
          itemBuilder: (context, index) {
            var item = bookList[index];
            return _buildListItem(context, item);
          },
        );
      },
    );
  }

  Widget _buildListItem(context, var item) {
    return Card(
      elevation: 2,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          onTap: () {
            AccountPage.isUserLogged() == false
                ? showDialog(
                    context: context,
                    builder: (context) => const AlertDialogUserCheck(
                        subText: "You should login to view or get a book."),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return BookDetailPage(book: item);
                      }),
                    ),
                  );
          },
          title: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.005,
                left: 5,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5), color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.network(item.image1),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.05 - 30) / 2,
                left: MediaQuery.of(context).size.width * 0.17,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(item.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.05 - 30) / 2 + 23,
                left: MediaQuery.of(context).size.width * 0.17,
                child: Text(
                  item.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySearchDelegate extends SearchDelegate<Category> {
  CategorySearchDelegate({required this.categoryList});
  final List<Category> categoryList;

  @override
  String get searchFieldLabel => 'Search Category';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Category> matchQuery = [];
    for (var i = 0; i < categoryList.length; i++) {
      if (categoryList[i].title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(categoryList[i]);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var item = matchQuery[index];
        return _buildListItem(context, item);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        var item = categoryList[index];
        return _buildListItem(context, item);
      },
    );
  }

  Widget _buildListItem(context, var item) {
    return Card(
      elevation: 2,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          onTap: () {
            close(context, item);
          },
          title: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.005,
                left: 5,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5), color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.network(item.imagePath, fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.055 - 16) / 2,
                left: MediaQuery.of(context).size.width * 0.17,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(item.title,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
