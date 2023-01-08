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
        decoration: Background().getBackground(),
        child: Center(
            child: Text(_reviewList.isEmpty ? "" : _reviewList.first.review)),
      ),
    );
  }
}
