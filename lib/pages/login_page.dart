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
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.35, 40),
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
            "Please enter the phone number to which the password reset code will be sent without 0 at the beginning.",
            style: TextStyle(fontSize: 18),
          ),
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
                    phoneNum.clear();
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
                  onPressed: () {
                    if (phoneNum.text.length == 10) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgotPassword(
                              phoneNumber: int.parse(phoneNum.text),
                            );
                          },
                        ),
                      );
                    }
                  },
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

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  int? phoneNumber;
  ForgotPassword({super.key, this.phoneNumber});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _showPassword = true;
  bool _showPassword_1 = true;
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
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
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    "The reset code was sent to the phone number: +90${widget.phoneNumber}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: "Please enter the code",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    validator: Validators.compose(
                      [
                        Validators.patternRegExp(
                            RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'),
                            "Password must contain at least one uppercase letter, one lowercase letter, one number and must be at least 8 characters long.")
                      ],
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                    maxLength: 15,
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      filled: true,
                      errorMaxLines: 3,
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
                      labelText: "New password",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      hintText: "Please enter your password",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: _showPassword_1,
                    validator: (value) {
                      if (value != _password) {
                        return 'Password is not matching!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      errorMaxLines: 3,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword_1 = !_showPassword_1;
                          });
                        },
                        icon: Icon(
                          _showPassword_1
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      labelText: "New password again",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      hintText: "Please enter password again",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.35, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
