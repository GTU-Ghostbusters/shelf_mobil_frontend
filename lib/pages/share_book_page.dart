import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf_mobil_frontend/enums.dart';
import 'package:shelf_mobil_frontend/models/author.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../screens/select_photo.dart';
import '../models/category.dart';
import 'account_page.dart';
import 'home_page.dart';

class ShareBookPage extends StatefulWidget {
  const ShareBookPage({super.key});

  @override
  State<ShareBookPage> createState() => _ShareBookPageState();
}

class _ShareBookPageState extends State<ShareBookPage> {
  List<Category>? _categoryList = [];

  Category? _selectedCategory;

  CargoPaymentType _cargoPaymentType = CargoPaymentType.senderPays;
  final Author _author = Author(name: "Sabahattin Ali");

  @override
  void initState() {
    super.initState();
    _categoryList = HomePage.getCategories();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> imageBase64List = [];

  Future _convertBase64Files() async {
    for (var i = imageFileList.length; i < 3; i++) {
      imageBase64List.add("data:image/jpeg;base64,empty");
    }
  }

  Future _pickImages(ImageSource source) async {
    if (source == ImageSource.camera) {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        var bytes = await image.readAsBytes();
        var base64 = "data:image/jpeg;base64,${base64Encode(bytes)}";
        imageBase64List.add(base64);
        setState(() {
          imageFileList.add(image);
        });
      } on Exception {
        Navigator.of(context).pop();
      }
    } else {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length <= 3 &&
            imageFileList.length + selectedImages.length <= 3) {
          imageFileList.addAll(selectedImages);
          for (var image in selectedImages) {
            var bytes = await image.readAsBytes();
            var base64 = "data:image/jpeg;base64,${base64Encode(bytes)}";
            imageBase64List.add(base64);
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text("Close"))
              ],
              title: const Text("Number of Images"),
              contentPadding: const EdgeInsets.all(20),
              content: const Text("You can add maximum 3 images."),
            ),
          );
        }
        setState(() {});
      }
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
                onTap: _pickImages,
              ),
            );
          }),
    );
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController numberOfPagesInput = TextEditingController();
  TextEditingController bookNameInput = TextEditingController();

  TextEditingController bookAbstractInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDesign().createAppBar("SHARE BOOK", const SizedBox(), []),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: Background().getBackground(),
        child: AccountPage.isUserLogged() == false
            ? const Center(
                child: AlertDialogUserCheck(
                    subText: "You should login to upload a book."))
            : Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      imageFileList.isEmpty
                          ? uploadButton()
                          : showSelectedImages(),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Book name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        controller: bookNameInput,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.menu_book,
                              color: Colors.grey.shade900,
                            ),
                            labelText: "Book Name",
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Please enter book name",
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(height: 7),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Author name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              Icon(Icons.person, color: Colors.grey.shade900),
                          labelText: "Author Name",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter author name",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 7),
                      TextFormField(
                        controller: numberOfPagesInput,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              Icon(Icons.numbers, color: Colors.grey.shade900),
                          labelText: "Number Of Pages",
                          counterText: "",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter number of pages",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 7),
                      DropdownButtonFormField<Category>(
                        value: _selectedCategory,
                        items: _categoryList!
                            .map(
                              (item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.title),
                              ),
                            )
                            .toList(),
                        onChanged: (item) =>
                            setState(() => _selectedCategory = item),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.type_specimen,
                              color: Colors.grey.shade900),
                          labelText: " Category",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please choose category of book",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 7),
                      TextFormField(
                        controller: bookAbstractInput,
                        keyboardType: TextInputType.text,
                        maxLength: 300,
                        maxLines: 4,
                        minLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.text_snippet_rounded,
                              color: Colors.grey.shade900),
                          labelText: "Details of book",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter details of book",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 7),
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
                            Icon(Icons.local_shipping,
                                size: MediaQuery.of(context).size.width * 0.075,
                                color: Colors.grey.shade900),
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
                          onPressed: (() {
                            var shipmentType =
                                _cargoPaymentType == CargoPaymentType.senderPays
                                    ? "S"
                                    : "R";
                            _convertBase64Files();
                            Book book = Book.shareBook(
                                bookNameInput.text.toString(),
                                63,
                                6,
                                _selectedCategory!.categoryID,
                                int.parse(numberOfPagesInput.text.toString()),
                                1,
                                bookAbstractInput.text.toString(),
                                shipmentType,
                                imageBase64List[0],
                                imageBase64List[1],
                                imageBase64List[2]);
                            ApiService().addBook(book);
                            setState(() {});
                          }),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.4, 40),
                          ),
                          child: const Text("UPLOAD")),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget uploadButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _showSelectPhotoOptions(context);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          borderOnForeground: true,
          color: const Color.fromARGB(240, 255, 255, 255),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "UPLOAD BOOK IMAGES",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.visible),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Icon(Icons.add_photo_alternate_outlined, size: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget showSelectedImages() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 0, 0, 0),
        border:
            Border.all(color: const Color.fromARGB(200, 37, 37, 37), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageFileList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.012,
                          vertical: 5),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.239,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2))),
                      child: Image.file(
                        File(imageFileList[index].path),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageFileList.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(240, 255, 255, 255),
                            shape: BoxShape.circle,
                          ),
                          child:
                              const Icon(Icons.remove_circle_outline, size: 22),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: imageFileList.length < 3
                      ? MaterialStatePropertyAll(Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll(Colors.grey.shade600)),
              onPressed: (() {
                imageFileList.length < 3
                    ? _showSelectPhotoOptions(context)
                    : null;
              }),
              child: const Icon(Icons.add_a_photo_rounded)),
        ],
      ),
    );
  }
}
