import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(60, 255, 131, 220),
              Color.fromARGB(60, 246, 238, 243),
              Color.fromARGB(60, 76, 185, 252),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                label: "Name",
                text: "user name",
                onChanged: (name) {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Surname",
                text: "user surname",
                onChanged: (surname) {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Email",
                text: "user email",
                onChanged: (email) {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Phone Number",
                text: "user phone",
                onChanged: (phone) {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Password",
                text: "user password",
                onChanged: (password) {},
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Address",
                maxLines: 3,
                text: "user address",
                onChanged: (address) {},
              ),
            ],
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
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
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
          Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxLines,
          ),
        ],
      );
}
