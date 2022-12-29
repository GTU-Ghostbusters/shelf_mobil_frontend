import 'package:flutter/material.dart';

import '../pages/account_page.dart';

class AlertDialogUserCheck extends StatelessWidget {
  const AlertDialogUserCheck({super.key, required this.subText});
  final String subText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AccountPage();
                  },
                ),
              );
            }),
            child: const Text(
              "USER PAGE",
              style: TextStyle(fontSize: 18),
            ))
      ],
      title: const Text("USER LOGIN NEED"),
      contentPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.center,
      content: Text(subText),
    );
  }
}
