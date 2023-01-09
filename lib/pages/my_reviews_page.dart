import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/review.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class MyReviewsPage extends StatefulWidget {
  User? user;
  MyReviewsPage({required this.user, super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  List<Review> _reviewList = [];

  @override
  void initState() {
    super.initState();
    getData();
    getUser();
  }

  void getUser() async {
    var response = await ApiService.getUserList();
    List<User> list = userFromJsonID(response.body);
    for (var i = 0; i < list.length; i++) {
      for (var j = 0; j < _reviewList.length; j++) {
        if (_reviewList[j].buyerId == list[i].userId) {
          _reviewList[j].buyerName = list[i].name;
        }
      }
    }
    setState(() {});
  }

  void getData() async {
    var response = await ApiService.getReviewList(widget.user!.userId);
    _reviewList = reviewFromJson(response.body);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
          "My Reviews",
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    _reviewList.isEmpty
                        ? "0 review"
                        : _reviewList.length == 1
                            ? "1 review"
                            : "${_reviewList.length} reviews",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _reviewList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            _reviewList[index].buyerName,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            _reviewList[index].review,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: ((context, ind) {
                                return ind < _reviewList[index].point
                                    ? Icon(Icons.star,
                                        color: Colors.yellow.shade800)
                                    : Icon(Icons.star,
                                        color: Colors.grey.shade700);
                              })),
                        ),
                      ],
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
