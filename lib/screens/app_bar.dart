import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class AppBarDesign {
  PreferredSize createAppBar(String title, Widget leading, List<Widget> actions) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(58),
      child: AppBar(
          title: Text(title,
              style: TextStyle(color: Colors.grey.shade900, fontSize: 21)),
          centerTitle: true,
          flexibleSpace: Container(decoration: Background().getBackground()),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 0.2, color: Colors.grey.shade700),
          ),
          leading: leading,
          actions: actions),
    );
  }
}
