import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  static void assignUser(User other) {
    _MyInfoPageState.user = other;
  }

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  static User? user;
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
                  icon: Icon(Icons.person, color: Colors.grey.shade900),
                  label: "Name",
                  text: user!.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.email_rounded, color: Colors.grey.shade900),
                  label: "Email",
                  text: user!.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.phone, color: Colors.grey.shade900),
                  label: "Phone Number",
                  text: user!.phoneNumber,
                  onChanged: (phone) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.lock_outline, color: Colors.grey.shade900),
                  label: "Password",
                  text: user!.password,
                  onChanged: (password) {},
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  icon: Icon(Icons.location_on, color: Colors.grey.shade900),
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
