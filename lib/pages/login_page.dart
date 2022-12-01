import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  bool _selectItem = true;
  TextEditingController phoneNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(70, 255, 131, 220),
              Color.fromARGB(70, 246, 238, 243),
              Color.fromARGB(70, 76, 185, 252),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    initialLabelIndex: _selectItem ? 0 : 1,
                    cornerRadius: 20.0,
                    fontSize: 15,
                    borderWidth: 3,
                    activeFgColor: Colors.white,
                    activeBgColor: [
                      Theme.of(context).primaryColor,
                    ],
                    inactiveFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    totalSwitches: 2,
                    labels: const ['E-mail', 'Phone'],
                    onToggle: (index) {
                      setState(() {
                        _selectItem = !_selectItem;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      keyboardType: _selectItem
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: _selectItem
                            ? const Icon(Icons.email_rounded)
                            : const Icon(Icons.phone),
                        labelText: _selectItem ? "E-mail" : "Phone number",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: _selectItem
                            ? "Please enter your email"
                            : "Please enter your phone number",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      obscureText: _showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Please enter your password",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => dialogBuilder(context),
                        child: const Text(
                          "Forgot my password",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.login),
                    label: const Text("LOGIN"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Password Reset"),
          content: const Text(
              "Please enter the phone number to which the password reset code will be sent without 0 at the beginning."),
          actions: <Widget>[
            TextFormField(
              controller: phoneNum,
              maxLength: 10,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "Phone number",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
