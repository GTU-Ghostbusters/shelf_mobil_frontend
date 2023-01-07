import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDesign().createAppBar(
            "My Reviews", BackButton(color: Colors.grey.shade900), []),
        body: Container(
          padding: const EdgeInsets.all(26),
          decoration: Background().getBackground(),
        ));
  }
}
