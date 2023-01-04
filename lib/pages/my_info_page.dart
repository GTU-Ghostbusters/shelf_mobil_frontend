import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarDesign().createAppBar("My Informations", const SizedBox(), []),
      body: Container(
        padding: const EdgeInsets.all(26),
        decoration: Background().getBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget(
                  icon: const Icon(Icons.person),
                  label: "Name",
                  text: "user name",
                  onChanged: (name) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: const Icon(Icons.person),
                  label: "Surname",
                  text: "user surname",
                  onChanged: (surname) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: const Icon(Icons.email_rounded),
                  label: "Email",
                  text: "user email",
                  onChanged: (email) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: const Icon(Icons.phone),
                  label: "Phone Number",
                  text: "user phone",
                  onChanged: (phone) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: const Icon(Icons.lock_outline),
                  label: "Password",
                  text: "user password",
                  onChanged: (password) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: const Icon(Icons.location_on),
                  label: "Address",
                  maxLines: 3,
                  text: "user address",
                  onChanged: (address) {},
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
