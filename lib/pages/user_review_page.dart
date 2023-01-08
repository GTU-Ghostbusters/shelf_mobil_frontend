import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class UserReviewPage extends StatefulWidget {
  final User user;
  const UserReviewPage({required this.user, super.key});

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarDesign().createAppBar(widget.user.name, BackButton(color: Colors.grey.shade900,), []),
      body: Container(decoration: Background().getBackground()),
    );
  }
}
