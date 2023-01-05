import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class ShipmentConfirmationPage extends StatefulWidget {
  const ShipmentConfirmationPage({super.key, required this.confirmedBookList});

  final List<Book> confirmedBookList;
  @override
  State<ShipmentConfirmationPage> createState() =>
      _ShipmentConfirmationPageState();
}

class _ShipmentConfirmationPageState extends State<ShipmentConfirmationPage> {
  late City _selectedCity;
  // dont delete
  // ignore: unused_field
  late Town _selectedTown;
  late List<City> _cityList;

  @override
  void initState() {
    super.initState();
    getData();
    _selectedCity = _cityList.first;
    _selectedTown = _selectedCity.townList.first;
  }

  void getData() async {
    _cityList = (await ApiService().getCities());

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() {}));
  }

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
            DropdownButtonFormField<City>(
              value: _selectedCity,
              items: _cityList
                  .map(
                    (item) => DropdownMenuItem<City>(
                      value: item,
                      child: Text(item.cityName),
                    ),
                  )
                  .toList(),
              onChanged: (item) => setState(() => _selectedCity = item!),
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.type_specimen),
                labelText: "City",
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "Please choose city",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<Town>(
              value: _selectedCity.townList.first,
              items: _selectedCity.townList
                  .map(
                    (item) => DropdownMenuItem<Town>(
                      value: item,
                      child: Text(item.townName),
                    ),
                  )
                  .toList(),
              onChanged: (item) => setState(() => _selectedTown = item!),
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.type_specimen),
                labelText: "Town",
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "Please choose town",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
