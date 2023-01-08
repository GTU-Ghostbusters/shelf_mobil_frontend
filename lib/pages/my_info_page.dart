import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  static void changeField(String name, String email, String phone,
      String password, String address) {
    _MyInfoPageState.name_ = name;
    _MyInfoPageState.email_ = email;
    _MyInfoPageState.phone_ = phone;
    _MyInfoPageState.address_ = address;
  }

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  static int id_ = 0;
  static String name_ = "";
  static String email_ = "";
  static String phone_ = "";
  static String address_ = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Response response = await ApiService.getLoggedUser();
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      id_ = data["id"];
      name_ = data["name"];
      email_ = data["email"];
      address_ = "";
      phone_ = data["phone"];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
          "My Informations", BackButton(color: Colors.grey.shade900), []),
      body: Container(
        padding: const EdgeInsets.all(26),
        decoration: Background().getBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget(
                  icon: Icon(Icons.person, color: Colors.grey.shade900),
                  label: "Name",
                  text: name_,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.email_rounded, color: Colors.grey.shade900),
                  label: "Email",
                  text: email_,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.phone, color: Colors.grey.shade900),
                  label: "Phone Number",
                  text: phone_,
                  onChanged: (phone) {},
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.location_on, color: Colors.grey.shade900),
                  label: "Address",
                  maxLines: 3,
                  text: address_,
                  onChanged: (address) {},
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final Icon icon;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.icon,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Card(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: widget.icon,
              ),
              maxLines: widget.maxLines,
            ),
          )
        ],
      );
}
