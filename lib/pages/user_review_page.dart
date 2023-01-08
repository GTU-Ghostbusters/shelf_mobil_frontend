import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/review.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class UserReviewPage extends StatefulWidget {
  User? user;
  UserReviewPage({required this.user, super.key});

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  List<Review> _reviewList = [];

  @override
  void initState() {
    super.initState();
    getData();
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
          widget.user!.name,
          BackButton(
            color: Colors.grey.shade900,
          ),
          []),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: Column(
          children: [
            Card(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  _reviewList.isEmpty
                      ? "0 review"
                      : _reviewList.length == 1
                          ? "1 review"
                          : "${_reviewList.length} reviews",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
                ),
              ]),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _reviewList.length,
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
                          Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        _reviewList.first.review,
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
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                    child: Text(
                                      _reviewList.first.buyerId.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
