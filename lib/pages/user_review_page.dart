import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';

class UserReviewPage extends StatefulWidget {
  String user_name;
  UserReviewPage({
    required this.user_name,
    super.key
    }
  );

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarDesign().createAppBar(widget.user_name, const SizedBox(), []),
    );
  }
}
