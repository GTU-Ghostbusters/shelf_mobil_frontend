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
  TextEditingController cityController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController openAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isAddressAdd = false;
  Address? _selectedAddress = Address(
      addressName: "", city: "", town: "", openAddress: "", phoneNumber: "");
  List<Address> _addressList = [
    Address(
        addressName: "", city: "", town: "", openAddress: "", phoneNumber: "")
  ];

  @override
  void initState() {
    super.initState();
    getAddressList();
  }

  void getAddressList() async {
    var response = await ApiService.getAdresses();
    _addressList = addressFromJson(response.body);
    if(_addressList.isEmpty){
      _addressList.add(
    Address(
        addressName: "", city: "", town: "", openAddress: "", phoneNumber: ""));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDesign().createAppBar(
          "ADD TO SHELF", BackButton(color: Colors.grey.shade900), []),
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: Background().getBackground(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _isAddressAdd ? getAddressInput() : getAddressDropdown(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isAddressAdd
                          ? TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bool checkAdd = true;
                                  for (var i = 0;
                                      i < _addressList.length;
                                      i++) {
                                    if (addressNameController.text.toString() ==
                                        _addressList[i].addressName) {
                                      checkAdd = false;
                                      break;
                                    }
                                  }
                                  if (checkAdd) {
                                    ApiService.addAdress(Address(
                                        addressName: addressNameController.text
                                            .toString(),
                                        city: cityController.text.toString(),
                                        town: townController.text.toString(),
                                        openAddress: openAddressController.text
                                            .toString(),
                                        phoneNumber:
                                            phoneController.text.toString()));
                                  }
                                }

                                getAddressList();
                                setState(() {
                                  _isAddressAdd = !_isAddressAdd;
                                });
                              },
                              child: const Text("Create"))
                          : const Text(""),
                      TextButton(
                        onPressed: () {
                          getAddressList();
                          setState(() {
                            _isAddressAdd = !_isAddressAdd;
                          });
                        },
                        child: Text(_isAddressAdd
                            ? "Choose Existing Address"
                            : "Add New Address"),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, () {
                      setState(() {});
                    });
                  },
                  child: const Text("ADD TO SHELF"))
            ]),
      ),
    );
  }

  Widget getAddressDropdown() {
    return DropdownButtonFormField<Address>(
      value: _addressList.first,
      items: _addressList
          .map(
            (item) => DropdownMenuItem<Address>(
              value: item,
              child: Text("${item.addressName}, ${item.city}, ${item.town}"),
            ),
          )
          .toList(),
      onChanged: (item) => setState(() => _selectedAddress = item),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.type_specimen, color: Colors.grey.shade900),
        labelText: "Address",
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: "Please choose an address",
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget getAddressInput() {
    return SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
