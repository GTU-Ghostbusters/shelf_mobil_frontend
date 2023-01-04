import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
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
                      keyboardType: _selectItem
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      decoration: InputDecoration(
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
                  onPressed: () {
                    if (emailCheck == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgotPassword(
                              email: email_.text.toString(),
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
  String? email;
  ForgotPassword({super.key, this.email});

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
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Please enter the code",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 5),
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
                    //maxLength: 15,
                    obscureText: _showPassword,
                    decoration: InputDecoration(
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
                    obscureText: _showPassword_1,
                    validator: (value) {
                      if (value != _password) {
                        return 'Password is not matching!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
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
