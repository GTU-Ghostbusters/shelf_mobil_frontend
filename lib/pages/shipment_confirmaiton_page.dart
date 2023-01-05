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
  late City _selectedCity;
  late Town _selectedTown;
  late final List<City> _cityList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().createAppBar(
          "ADD TO SHELF", BackButton(color: Colors.grey.shade900), []),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
                child: const Text("ADD TO SHELF"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
