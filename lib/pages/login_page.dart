import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';
import 'package:shelf_mobil_frontend/pages/home_page.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';
import 'package:shelf_mobil_frontend/services/storage_service.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:email_validator/email_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  bool _selectItem = true;

  TextEditingController email_ = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign()
          .createAppBar("LOGIN", BackButton(color: Colors.grey.shade900), []),
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
                  Card(
                    child: TextFormField(
                      maxLength: _selectItem ? 1000 : 10,
                      controller:
                          _selectItem ? emailController : phoneController,
                      keyboardType: _selectItem
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: _selectItem
                            ? Icon(Icons.email_rounded,
                                color: Colors.grey.shade900)
                            : Icon(Icons.phone, color: Colors.grey.shade900),
                        labelText: _selectItem ? "E-mail" : "Phone number",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: _selectItem
                            ? "Please enter your email"
                            : "Please enter your phone number",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.grey.shade900),
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
                        hintText: "Please enter your password",
                        border: const OutlineInputBorder(),
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
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.35, 40),
                    ),
                    onPressed: () async {
                      Response response = await ApiService.login(
                          _selectItem
                              ? emailController.text
                              : phoneController.text,
                          passwordController.text);

                      Map<String, dynamic> res = jsonDecode(response.body);

                      if (res["result"].toString() == "true") {
                        StorageService.storeToken(
                            res["access_token"].toString());
                        AccountPage.changeLog(res["access_token"].toString());

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const HomePage();
                            },
                          ),
                        );
                      } else if (res["result"].toString() == "false") {
                        // ignore: use_build_context_synchronously
                        dialog(
                          context,
                          Text(
                            res["message"].toString(),
                            style: const TextStyle(fontSize: 18),
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
                      }
                    },
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
    bool emailCheck = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Password Reset"),
          content: const Text(
            "Please enter the e-mail to reset the password.",
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: email_,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  if (!EmailValidator.validate(email!)) {
                    return 'Please enter a valid e-mail.';
                  } else {
                    emailCheck = true;
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.email_rounded, color: Colors.grey.shade900),
                  labelText: "E-mail",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    email_.clear();
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
                  onPressed: () async {
                    Response response =
                        await ApiService.resetPassword(email_.text);

                    Map<String, dynamic> emailReset = jsonDecode(response.body);

                    if (emailReset["status"].toString() == "true") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgotPassword(
                              email: email_.text,
                              userId: emailReset["user_id"],
                            );
                          },
                        ),
                      );
                    } else if (emailReset["status"].toString() == "false") {
                      // ignore: use_build_context_synchronously
                      _ForgotPasswordState().dialog(
                        context,
                        const Text(
                          "There is no user registered with this e-mail. Please try again.",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            email_.clear();
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

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  String? email;
  int userId;
  ForgotPassword({super.key, this.email, required this.userId});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _showPassword = true;
  bool _showPassword_1 = true;
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarDesign().createAppBar("FORGOT PASSWORD", const SizedBox(), []),
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
                    "The reset code was sent to the email: ${widget.email}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    maxLength: 6,
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        counterText: "",
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Please enter the code",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    validator: Validators.compose(
                      [
                        Validators.patternRegExp(
                            RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'),
                            "Password must contain at least one uppercase letter, one lowercase letter, one number and must be at least 8, at most 15 characters long.")
                      ],
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                    maxLength: 15,
                    obscureText: _showPassword,
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
                      labelText: "New password",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      hintText: "Please enter your password",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5),
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
                      errorMaxLines: 3,
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
                      labelText: "New password again",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      hintText: "Please enter password again",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.35, 40),
                    ),
                    onPressed: () async {
                      Response response = await ApiService.changePassword(
                          widget.userId,
                          codeController.text,
                          passwordController.text);

                      Map<String, dynamic> passReset =
                          jsonDecode(response.body);

                      if (passReset["status"].toString() == "true") {
                        // ignore: use_build_context_synchronously
                        dialog(
                          context,
                          const Text(
                            "Your password was changed. You can login with your new password.",
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
                      }
                    },
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
