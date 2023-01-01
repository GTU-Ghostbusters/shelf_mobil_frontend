import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/category.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class BookSearchButton extends StatelessWidget {
  const BookSearchButton({super.key, required this.categoryTitle});
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: BookSearchDelegate(categoryTitle: categoryTitle),
        );
      },
      icon: Icon(
        Icons.search_outlined,
        color: Colors.grey.shade900,
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate {
  BookSearchDelegate({required this.categoryTitle});
  String categoryTitle;

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
    return FutureBuilder<List<Book>>(
      future: ApiService().getBooksWithCategory(categoryTitle),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Book> bookList = data!;
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
    return FutureBuilder<List<Book>>(
      future: ApiService().getBooksWithCategory(categoryTitle),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Book> bookList = data!;

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
      child: ListTile(
        title: GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(0),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.0125,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5), color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Image.network(item.image),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height * 0.075 - 30) / 2,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height * 0.075 - 30) / 2 +
                      23,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    item.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return BookDetailPage(book: item);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategorySearchDelegate extends SearchDelegate<Category> {
  CategorySearchDelegate({required this.categoryList});
  final List<Category> categoryList;
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
      child: ListTile(
        title: GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(0),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.0125,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5), color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Image.asset(item.imagePath),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height * 0.075 - 16) / 2,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            close(context, item);
          },
        ),
      ),
    );
  }
}
