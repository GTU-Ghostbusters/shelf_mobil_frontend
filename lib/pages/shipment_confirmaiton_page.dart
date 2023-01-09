import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

class ShipmentConfirmationPage extends StatefulWidget {
  const ShipmentConfirmationPage({super.key, required this.confirmedBookList});

  final List<Book> confirmedBookList;
  @override
  State<ShipmentConfirmationPage> createState() =>
      _ShipmentConfirmationPageState();
}

class _ShipmentConfirmationPageState extends State<ShipmentConfirmationPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController openAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
          "ADD TO SHELF", BackButton(color: Colors.grey.shade900), []),
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: Background().getBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    validator: (name) {
                      if (name!.length < 2) {
                        return 'Address name must consist of at least 2 characters.';
                      } else {
                        return null;
                      }
                    },
                    controller: addressNameController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Address Name",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Please enter address name",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    validator: (city) {
                      if (city!.length < 3) {
                        return 'City name must consist of at least 3 characters.';
                      } else {
                        return null;
                      }
                    },
                    controller: cityController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "City Name",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Please enter city",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    validator: (town) {
                      if (town!.length < 3) {
                        return 'Town name must consist of at least 3 characters.';
                      } else {
                        return null;
                      }
                    },
                    controller: townController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Town Name",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Please enter town",
                        border: OutlineInputBorder()),
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
                    decoration: const InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "Please enter phone number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    validator: (openAddress) {
                      if (openAddress!.length < 10) {
                        return 'Open address must consist of at least 10 characters.';
                      } else {
                        return null;
                      }
                    },
                    controller: openAddressController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Open Address",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Please enter open address",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 13),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Address address = Address(
                            addressName: addressNameController.text,
                            city: cityController.text,
                            town: townController.text,
                            openAddress: openAddressController.text,
                            phoneNumber: phoneController.text.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.4, 40),
                    ),
                    child: const Text(
                      "ADD ADDRESS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
