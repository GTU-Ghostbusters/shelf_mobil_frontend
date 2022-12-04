import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';

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
  final CargoPaymentType _cargoPaymentType = CargoPaymentType.senderPays;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      setState(() {});
    }
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectImages();
                          });
                        },
                        child: const Text("data")),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: GridView.builder(
                          itemCount: imageFileList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(imageFileList![index].path),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
              // child: Form(
              //   key: _formKey,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   child: SingleChildScrollView(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const SizedBox(height: 15),
              //         ElevatedButton(
              //             onPressed: () {
              //               setState(() {
              //                 selectImages();
              //               });
              //             },
              //             child: const Text("data")),
              //         const SizedBox(height: 15),
              //        Expanded(
              //           child: Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: GridView.builder(
              //               itemCount: imageFileList!.length,
              //               gridDelegate:
              //                   const SliverGridDelegateWithFixedCrossAxisCount(
              //                       crossAxisCount: 3),
              //               itemBuilder: (context, index) {
              //                 return Image.file(
              //                   File(imageFileList![index].path),
              //                   fit: BoxFit.cover,
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         TextFormField(
              //           validator: (name) {
              //             if (name!.length < 5) {
              //               return 'Book name must consist of at least 5 characters.';
              //             } else {
              //               return null;
              //             }
              //           },
              //           decoration: const InputDecoration(
              //             filled: true,
              //             prefixIcon: Icon(Icons.menu_book),
              //             labelText: "Book Name",
              //             labelStyle: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             hintText: "Please enter book name",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(5),
              //               ),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         TextFormField(
              //           validator: (name) {
              //             if (name!.length < 5) {
              //               return 'Author name must consist of at least 5 characters.';
              //             } else {
              //               return null;
              //             }
              //           },
              //           decoration: const InputDecoration(
              //             filled: true,
              //             prefixIcon: Icon(Icons.person),
              //             labelText: "Author Name",
              //             labelStyle: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             hintText: "Please enter author name",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(5),
              //               ),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         TextFormField(
              //           controller: numberOfPages,
              //           keyboardType: TextInputType.number,
              //           maxLength: 4,
              //           decoration: const InputDecoration(
              //             filled: true,
              //             prefixIcon: Icon(Icons.numbers),
              //             labelText: "Number Of Pages",
              //             labelStyle: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             hintText: "Please enter number of pages",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(5),
              //               ),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         DropdownButtonFormField<Category>(
              //           value: _selectedCategory,
              //           items: _categories
              //               .map(
              //                 (item) => DropdownMenuItem<Category>(
              //                   value: item,
              //                   child: Text(item.title),
              //                 ),
              //               )
              //               .toList(),
              //           onChanged: (item) =>
              //               setState(() => _selectedCategory = item),
              //           decoration: const InputDecoration(
              //             filled: true,
              //             prefixIcon: Icon(Icons.type_specimen),
              //             labelText: " Category",
              //             labelStyle: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             hintText: "Please choose category of book",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(5),
              //               ),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         TextFormField(
              //           keyboardType: TextInputType.text,
              //           maxLength: 300,
              //           maxLines: 4,
              //           minLines: 1,
              //           decoration: const InputDecoration(
              //             filled: true,
              //             prefixIcon: Icon(Icons.text_snippet_rounded),
              //             labelText: "Details of book",
              //             labelStyle: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             hintText: "Please enter details of book",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5)),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 15),
              //         Container(
              //           width: MediaQuery.of(context).size.width * 0.8,
              //           decoration: BoxDecoration(
              //             color: const Color.fromARGB(10, 0, 0, 0),
              //             border: Border.all(
              //               width: 1,
              //               color: const Color.fromARGB(200, 37, 37, 37),
              //             ),
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               const SizedBox(width: 5),
              //               Icon(
              //                 Icons.local_shipping,
              //                 size: MediaQuery.of(context).size.width * 0.075,
              //                 color: const Color.fromARGB(200, 37, 37, 37),
              //               ),
              //               const SizedBox(width: 5),
              //               ToggleSwitch(
              //                 initialLabelIndex: _cargoPaymentType ==
              //                         CargoPaymentType.senderPays
              //                     ? 0
              //                     : 1,
              //                 cornerRadius: 5,
              //                 fontSize: 16,
              //                 borderWidth: 0,
              //                 activeFgColor: Colors.white,
              //                 activeBgColor: [Theme.of(context).primaryColor],
              //                 inactiveFgColor:
              //                     const Color.fromARGB(200, 37, 37, 37),
              //                 inactiveBgColor: Colors.white,
              //                 totalSwitches: 2,
              //                 minWidth:
              //                     MediaQuery.of(context).size.width * 0.33,
              //                 labels: const ['Sender', 'Receiver'],
              //                 onToggle: (index) {
              //                   setState(() {
              //                     _cargoPaymentType ==
              //                             CargoPaymentType.senderPays
              //                         ? _cargoPaymentType =
              //                             CargoPaymentType.receiverPays
              //                         : _cargoPaymentType =
              //                             CargoPaymentType.senderPays;
              //                   });
              //                 },
              //               ),
              //             ],
              //           ),
              //         ),
              //         const SizedBox(height: 25),
              //         ElevatedButton(
              //             onPressed: (() {}), child: const Text("UPLOAD")),
              //         const SizedBox(height: 15),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          );
  }
}
