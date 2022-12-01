import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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

  TextEditingController phoneNum = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN UP"),
      ),
      body: Container(
        padding: const EdgeInsets.all(17),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (name) {
                      if (name!.length < 3) {
                        return 'The name must consist of at least 3 characters.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter name",
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
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      labelText: "Surname",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter surname",
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
                    validator: (email) {
                      if (!EmailValidator.validate(email!)) {
                        return 'Please enter a valid e-mail.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter e-mail",
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
                    controller: phoneNum,
                    //maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone number",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter phone number",
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
                            "Password must contain at least one uppercase letter, one lowercase letter, one number and must be at least 8 characters long."),
                        Validators.maxLength(15,
                            "The password can be a maximum of 15 characters long."),
                      ],
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
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
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter password",
                      border: const OutlineInputBorder(
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
                    obscureText: _showPassword_1,
                    validator: (value) {
                      if (value != _password) {
                        return 'Password is not matching!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      errorMaxLines: 2,
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
                      labelText: "Password again",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                    height: 13,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.4, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
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
