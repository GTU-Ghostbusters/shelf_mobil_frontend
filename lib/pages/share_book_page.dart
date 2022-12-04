import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../screens/select_photo_options_screen.dart';
import '../types/category.dart';
import 'account_page.dart';

class ShareBookPage extends StatefulWidget {
  const ShareBookPage({super.key});

  @override
  State<ShareBookPage> createState() => _ShareBookPageState();
}

class _ShareBookPageState extends State<ShareBookPage> {
  final List<Category> _categories =
      Category.getCategoryListAlphabeticSorted().sublist(1);
  Category? _selectedCategory;
  CargoPaymentType _cargoPaymentType = CargoPaymentType.senderPays;
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException {
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController numberOfPages = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AccountPage.isUserLogged() == false
        ? const AccountPage()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text("SHARE BOOK"), centerTitle: true),
            body: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(40),
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
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      _image == null
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _showSelectPhotoOptions(context);
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [10, 5],
                                  color: const Color.fromARGB(100, 37, 37, 37),
                                  strokeWidth: 2,
                                  child: Card(
                                    color: const Color.fromARGB(
                                        240, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: Column(
                                      children: [
                                        const Text(
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          "UPLOAD BOOK IMAGES",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.visible),
                                        ),
                                        Icon(Icons.add_photo_alternate_outlined,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.075),
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(10, 0, 0, 0),
                                border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(200, 37, 37, 37),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Image(image: FileImage(_image!)),
                            ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Book name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.menu_book),
                          labelText: "Book Name",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter book name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Author name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          labelText: "Author Name",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter author name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: numberOfPages,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.numbers),
                          labelText: "Number Of Pages",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter number of pages",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<Category>(
                        value: _selectedCategory,
                        items: _categories
                            .map(
                              (item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.title),
                              ),
                            )
                            .toList(),
                        onChanged: (item) =>
                            setState(() => _selectedCategory = item),
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.type_specimen),
                          labelText: " Category",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please choose category of book",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 300,
                        maxLines: 4,
                        minLines: 1,
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.text_snippet_rounded),
                          labelText: "Details of book",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter details of book",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(10, 0, 0, 0),
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(200, 37, 37, 37),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 5),
                            Icon(
                              Icons.local_shipping,
                              size: MediaQuery.of(context).size.width * 0.075,
                              color: const Color.fromARGB(200, 37, 37, 37),
                            ),
                            const SizedBox(width: 5),
                            ToggleSwitch(
                              initialLabelIndex: _cargoPaymentType ==
                                      CargoPaymentType.senderPays
                                  ? 0
                                  : 1,
                              cornerRadius: 5,
                              fontSize: 16,
                              borderWidth: 0,
                              activeFgColor: Colors.white,
                              activeBgColor: [Theme.of(context).primaryColor],
                              inactiveFgColor:
                                  const Color.fromARGB(200, 37, 37, 37),
                              inactiveBgColor: Colors.white,
                              totalSwitches: 2,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.33,
                              labels: const ['Sender', 'Receiver'],
                              onToggle: (index) {
                                setState(() {
                                  _cargoPaymentType ==
                                          CargoPaymentType.senderPays
                                      ? _cargoPaymentType =
                                          CargoPaymentType.receiverPays
                                      : _cargoPaymentType =
                                          CargoPaymentType.senderPays;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                          onPressed: (() {}), child: const Text("UPLOAD")),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
