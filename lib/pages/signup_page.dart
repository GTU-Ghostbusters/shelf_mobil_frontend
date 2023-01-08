import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'package:shelf_mobil_frontend/pages/login_page.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showPassword = true;
  bool _showPassword_1 = true;
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign()
          .createAppBar("SIGN UP", BackButton(color: Colors.grey.shade900), []),
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
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (name) {
                      if (name!.length < 3) {
                        return 'The name must consist of at least 3 characters.';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon:
                          Icon(Icons.person, color: Colors.grey.shade900),
                      labelText: "Name",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter name",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: emailController,
                    validator: (email) {
                      if (!EmailValidator.validate(email!)) {
                        return 'Please enter a valid e-mail.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.email_rounded,
                          color: Colors.grey.shade900),
                      labelText: "E-mail",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter e-mail",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: phoneController,
                    validator: (phoneNumber) {
                      if (phoneNumber!.isEmpty || phoneNumber.length < 10) {
                        return "Please enter a valid phone number.";
                      } else {
                        return null;
                      }
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon:
                          Icon(Icons.phone, color: Colors.grey.shade900),
                      labelText: "Phone number",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter phone number",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: passwordController,
                    validator: Validators.compose(
                      [
                        Validators.patternRegExp(
                            RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'),
                            "Password must contain at least one uppercase letter, one lowercase letter, one number and must be at least 8, at most 15 characters long."),
                      ],
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: _showPassword,
                    maxLength: 15,
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      errorMaxLines: 3,
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.grey.shade900),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: _showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter password",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    maxLength: 15,
                    obscureText: _showPassword_1,
                    validator: (value) {
                      if (value != _password) {
                        return 'Password is not matching!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      errorMaxLines: 2,
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.grey.shade900),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword_1 = !_showPassword_1;
                          });
                        },
                        icon: _showPassword_1
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      labelText: "Password again",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter password again",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.4, 40),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Response response = await ApiService.register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            phoneController.text);

                        Map<String, dynamic> res = jsonDecode(response.body);

                        debugPrint(response.body.toString());

                        if (res["result"].toString() == "true") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Confirmation(
                                    email_: emailController.text,
                                    id: res["user_id"]);
                              },
                            ),
                          );
                        } else if (res["result"].toString() == "false") {
                          // ignore: use_build_context_synchronously
                          _ConfirmationState().dialog(
                            context,
                            const Text(
                              "The user already exists. Please try again.",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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

// ignore: must_be_immutable
class Confirmation extends StatefulWidget {
  int id;
  String? email_;
  Confirmation({super.key, this.email_, required this.id});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar("CONFIRMATION", const SizedBox(), []),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "The confirmation code was sent to the e-mail: ${widget.email_}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: TextFormField(
                      maxLength: 6,
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: "",
                        labelText: "Please enter the code",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      Response response = await ApiService.verifyEmail(
                          widget.id, codeController.text);
                      Map<String, dynamic> res = jsonDecode(response.body);

                      if (res["result"].toString() == "true") {
                        // ignore: use_build_context_synchronously
                        dialog(
                          context,
                          const Text(
                            "Your account was verified. You can login with your e-mail and password.",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const LoginPage();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else if (res["result"].toString() == "false") {
                        // ignore: use_build_context_synchronously
                        dialog(
                          context,
                          const Text(
                            "The entered code is incorrect. Please try again.",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              codeController.clear();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.4, 40),
                    ),
                    child: const Text(
                      "CONFIRM",
                      style: TextStyle(fontSize: 16),
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

  Future<void> dialog(BuildContext context, Widget content_, Widget actions_) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("MESSAGE"),
          content: content_,
          actions: <Widget>[actions_],
        );
      },
    );
  }
}
