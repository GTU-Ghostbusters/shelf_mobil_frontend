import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shelf_mobil_frontend/enums.dart';
import 'package:shelf_mobil_frontend/models/author.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../screens/select_photo.dart';
import '../models/category.dart';
import 'account_page.dart';

class ShareBookPage extends StatefulWidget {
  const ShareBookPage({super.key});

  @override
  State<ShareBookPage> createState() => _ShareBookPageState();
}

class _ShareBookPageState extends State<ShareBookPage> {
  List<Category>? _categoryList = [];
  Category? _selectedCategory;

  List<Author>? _authorList = [];
  Author? _selectedAuthor;

  User _user = User.getWithID(userId: 0, name: "");

  CargoPaymentType _cargoPaymentType = CargoPaymentType.senderPays;

  final _formKey = GlobalKey<FormState>();

  TextEditingController bookNameInput = TextEditingController();
  TextEditingController authorNameInput = TextEditingController();
  TextEditingController numberOfPagesInput = TextEditingController();
  TextEditingController bookAbstractInput = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> imageBase64List = ["", "", ""];

  bool _isAuthorAdd = false;

  @override
  void initState() {
    super.initState();
    getUser();
    getCategoryList();
    getAuthorList();
    noImageBase64Converter(0);
    noImageBase64Converter(1);
    noImageBase64Converter(2);
  }

  void getUser() async {
    var response = await ApiService.getLoggedUser();
    _user = User.fromJsonID(jsonDecode(response.body));
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    bookNameInput.clear();
    bookNameInput.dispose();
    authorNameInput.clear();
    authorNameInput.dispose();
    numberOfPagesInput.clear();
    numberOfPagesInput.dispose();
    bookAbstractInput.clear();
    bookAbstractInput.dispose();
  }

  void getCategoryList() async {
    var response = await ApiService.getCategories();
    _categoryList = categoryFromJson(response.body);
    _categoryList!
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _selectedCategory = _categoryList!.first;
    setState(() {});
  }

  void getAuthorList() async {
    var response = await ApiService.getAuthors();
    _authorList = authorFromJson(response.body);
    _authorList!
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    _selectedAuthor = _authorList!.first;
    setState(() {});
  }

  Future<void> noImageBase64Converter(int index) async {
    var bytes = await rootBundle.load("images/noImage.jpg");
    var buffer = bytes.buffer;
    var base64 =
        "data:image/jpeg;base64,${base64Encode(Uint8List.view(buffer))}";
    imageBase64List[index] = base64;
  }

  Future<void> imageAddAndConvertBase64(XFile image) async {
    imageFileList.add(image);
    Uint8List bytes = await File(image.path).readAsBytes();
    imageBase64List[imageFileList.length - 1] =
        ("data:image/jpeg;base64,${base64.encode(bytes)}");
  }

  Future _pickImages(ImageSource source) async {
    if (source == ImageSource.camera) {
      try {
        final image = await ImagePicker().pickImage(
            source: source, imageQuality: 30, maxHeight: 800, maxWidth: 600);
        if (image == null) return;
        imageAddAndConvertBase64(image);
        setState(() {});
      } on Exception {
        Navigator.of(context).pop();
      }
    } else {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length <= 3 &&
            imageFileList.length + selectedImages.length <= 3) {
          for (var i = 0; i < selectedImages.length; i++) {
            imageAddAndConvertBase64(selectedImages[i]);
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
                      const SizedBox(height: 10),
                      imageFileList.isEmpty
                          ? uploadImageButton()
                          : showSelectedImages(),
                      const SizedBox(height: 15),
                      getBookNameInput(),
                      const SizedBox(height: 10),
                      getAuthorInput(),
                      const SizedBox(height: 5),
                      getCategoryInput(),
                      const SizedBox(height: 10),
                      getNumberOfPagesInput(),
                      const SizedBox(height: 10),
                      getBookAbstractInput(),
                      const SizedBox(height: 10),
                      getShipmentTypeInput(),
                      const SizedBox(height: 25),
                      uploadButton(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget uploadImageButton() {
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
                            noImageBase64Converter(index);
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

  Widget getBookNameInput() {
    return TextFormField(
      validator: (name) {
        if (name!.length < 2) {
          return 'Book name must consist of at least 2 characters.';
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
    );
  }

  Widget getAuthorInput() {
    return Column(
      children: [
        _isAuthorAdd
            ? TextFormField(
                validator: (name) {
                  if (name!.length < 3) {
                    return 'Author name must consist of at least 3 characters.';
                  } else {
                    return null;
                  }
                },
                controller: authorNameInput,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.menu_book,
                      color: Colors.grey.shade900,
                    ),
                    labelText: "Author Name",
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Please enter author name",
                    border: const OutlineInputBorder()),
              )
            : DropdownButtonFormField<Author>(
                value: _selectedAuthor,
                items: _authorList!
                    .map(
                      (item) => DropdownMenuItem<Author>(
                        value: item,
                        child: Text(item.name),
                      ),
                    )
                    .toList(),
                onChanged: (item) => setState(() => _selectedAuthor = item),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      Icon(Icons.type_specimen, color: Colors.grey.shade900),
                  labelText: "Author",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Please choose author of book",
                  border: const OutlineInputBorder(),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _isAuthorAdd
                ? TextButton(
                    onPressed: () {
                      bool checkAdd = true;
                      for (var i = 0; i < _authorList!.length; i++) {
                        if (authorNameInput.text.toString() ==
                            _authorList![i].name) {
                          checkAdd = false;
                          break;
                        }
                      }
                      if (checkAdd) {
                        ApiService.addAuthor(Author.createNew(
                            name: authorNameInput.text.toString()));
                      }

                      getAuthorList();
                      setState(() {
                        _isAuthorAdd = !_isAuthorAdd;
                      });
                    },
                    child: const Text("Create"))
                : const Text(""),
            TextButton(
              onPressed: () {
                getAuthorList();
                setState(() {
                  _isAuthorAdd = !_isAuthorAdd;
                });
              },
              child: Text(
                  _isAuthorAdd ? "Choose Existing Author" : "Add New Author"),
            ),
          ],
        ),
      ],
    );
  }

  Widget getCategoryInput() {
    return DropdownButtonFormField<Category>(
      value: _selectedCategory,
      items: _categoryList!
          .map(
            (item) => DropdownMenuItem<Category>(
              value: item,
              child:
                  Text(item.title[0] + item.title.substring(1).toLowerCase()),
            ),
          )
          .toList(),
      onChanged: (item) => setState(() => _selectedCategory = item),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.type_specimen, color: Colors.grey.shade900),
        labelText: "Category",
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: "Please choose category of book",
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget getNumberOfPagesInput() {
    return TextFormField(
      validator: (number) {
        if (number!.isEmpty) {
          return 'Number of pages must be entered.';
        } else {
          return null;
        }
      },
      controller: numberOfPagesInput,
      keyboardType: TextInputType.number,
      maxLength: 4,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.numbers, color: Colors.grey.shade900),
        labelText: "Number Of Pages",
        counterText: "",
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: "Please enter number of pages",
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget getBookAbstractInput() {
    return TextFormField(
      validator: (abstract) {
        if (abstract!.length < 5) {
          return 'Book detail must be entered.';
        } else {
          return null;
        }
      },
      controller: bookAbstractInput,
      keyboardType: TextInputType.text,
      maxLength: 300,
      maxLines: 4,
      minLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon:
            Icon(Icons.text_snippet_rounded, color: Colors.grey.shade900),
        labelText: "Details of book",
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: "Please enter details of book",
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget getShipmentTypeInput() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(200, 37, 37, 37),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          Icon(Icons.local_shipping, size: 20, color: Colors.grey.shade900),
          const SizedBox(width: 5),
          ToggleSwitch(
            initialLabelIndex:
                _cargoPaymentType == CargoPaymentType.senderPays ? 0 : 1,
            cornerRadius: 4,
            fontSize: 16,
            borderWidth: 0,
            activeFgColor: Colors.white,
            activeBgColor: [Theme.of(context).primaryColor],
            inactiveFgColor: const Color.fromARGB(200, 37, 37, 37),
            inactiveBgColor: Colors.white,
            totalSwitches: 2,
            minWidth: MediaQuery.of(context).size.width * 0.33,
            labels: const ['Sender', 'Receiver'],
            onToggle: (index) {
              setState(() {
                _cargoPaymentType == CargoPaymentType.senderPays
                    ? _cargoPaymentType = CargoPaymentType.receiverPays
                    : _cargoPaymentType = CargoPaymentType.senderPays;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget uploadButton() {
    return ElevatedButton(
        onPressed: (() async {
          if (_formKey.currentState!.validate()) {
            var shipmentType =
                _cargoPaymentType == CargoPaymentType.senderPays ? "S" : "R";
            Book book = Book.shareBook(
                bookNameInput.text.toString(),
                _user.userId,
                _selectedAuthor!.authorID,
                _selectedCategory!.categoryID,
                int.parse(numberOfPagesInput.text.toString()),
                1,
                bookAbstractInput.text.toString(),
                shipmentType,
                imageBase64List[0],
                imageBase64List[1],
                imageBase64List[2]);
            var response = await ApiService.addBook(book);

            setState(() {
              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    content: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text(
                        "Book is uploaded to system.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green.shade800,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    content: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text(
                        ("Book could not uploaded to system."),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color.fromARGB(255, 255, 77, 77),
                  ),
                );
              }
            });
          }
        }),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
          backgroundColor: (_formKey.currentState != null &&
                  _formKey.currentState!.validate())
              ? Theme.of(context).primaryColor
              : Colors.grey.shade500,
        ),
        child: const Text("UPLOAD"));
  }
}
