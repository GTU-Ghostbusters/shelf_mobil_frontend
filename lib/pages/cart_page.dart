import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/cart_item.dart';
import 'package:shelf_mobil_frontend/pages/book_detail_page.dart';
import 'package:shelf_mobil_frontend/screens/alert_dialog.dart';
import 'package:shelf_mobil_frontend/screens/app_bar.dart';
import 'package:shelf_mobil_frontend/screens/background.dart';

import 'account_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static void addToCart(Book book) {
    cartItems.add(CartItem(bookItem: book));
  }

  static bool isAddedToCart(Book book) {
    return cartItems.contains(CartItem(bookItem: book));
  }

  static final List<CartItem> cartItems = [];
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem>? choosenItems = [];
  bool isAllItemsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign()
          .createAppBar("MY CART", BackButton(color: Colors.grey.shade900), []),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: Background().getBackground(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        "Your right: 1",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        choosenItems!.isEmpty
                            ? "No book is chosen"
                            : choosenItems!.length == 1
                                ? "1 book is chosen"
                                : "${choosenItems!.length} books are chosen",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isAllItemsSelected) {
                          isAllItemsSelected = !isAllItemsSelected;
                          for (var cartItem in CartPage.cartItems) {
                            cartItem.value = false;
                            choosenItems?.remove(cartItem);
                          }
                        } else {
                          isAllItemsSelected = !isAllItemsSelected;
                          for (var cartItem in CartPage.cartItems) {
                            if (!cartItem.value) {
                              cartItem.value = true;
                              choosenItems?.add(cartItem);
                            }
                          }
                        }
                      });
                    },
                    icon: Icon(Icons.select_all_outlined,
                        color:
                            isAllItemsSelected && CartPage.cartItems.isNotEmpty
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade600),
                  ),
                  Text(
                    CartPage.cartItems.isEmpty
                        ? "Empty"
                        : CartPage.cartItems.length == 1
                            ? "1 book"
                            : "${CartPage.cartItems.length} books",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        CartPage.cartItems.clear();
                        choosenItems?.clear();
                        isAllItemsSelected = false;
                      });
                    },
                    icon: Icon(Icons.delete_sweep_outlined,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: CartPage.cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: CartPage.cartItems[index].value
                            ? const Color.fromARGB(200, 187, 222, 251)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        children: [
                          Checkbox(
                              value: CartPage.cartItems[index].value,
                              onChanged: (value) {
                                setState(() {
                                  CartPage.cartItems[index].value =
                                      !CartPage.cartItems[index].value;
                                  CartPage.cartItems[index].value
                                      ? choosenItems
                                          ?.add(CartPage.cartItems[index])
                                      : choosenItems
                                          ?.remove(CartPage.cartItems[index]);
                                  CartPage.cartItems.length ==
                                          choosenItems?.length
                                      ? isAllItemsSelected = true
                                      : isAllItemsSelected = false;
                                });
                              }),
                          GestureDetector(
                            onTap: (() {
                              CartPage.cartItems[index].value
                                  ? null
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return BookDetailPage(
                                              book: CartPage
                                                  .cartItems[index].bookItem);
                                        },
                                      ),
                                    );
                            }),
                            onLongPress: () {
                              setState(() {
                                CartPage.cartItems[index].value =
                                    !CartPage.cartItems[index].value;
                                CartPage.cartItems[index].value
                                    ? choosenItems
                                        ?.add(CartPage.cartItems[index])
                                    : choosenItems
                                        ?.remove(CartPage.cartItems[index]);
                                CartPage.cartItems.length ==
                                        choosenItems?.length
                                    ? isAllItemsSelected = true
                                    : isAllItemsSelected = false;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.68,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.0125,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(width: 0.5),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.125,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Image.network(
                                        CartPage
                                            .cartItems[index].bookItem.image1,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    left: MediaQuery.of(context).size.width *
                                        0.24,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        CartPage.cartItems[index].bookItem.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                            0.02 +
                                        25,
                                    left: MediaQuery.of(context).size.width *
                                        0.24,
                                    child: Text(
                                      CartPage.cartItems[index].bookItem.author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                    left: MediaQuery.of(context).size.width *
                                        0.24,
                                    child: Text(
                                        CartPage
                                            .cartItems[index].bookItem.donator,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                CartPage.cartItems[index].value
                                    ? choosenItems
                                        ?.remove(CartPage.cartItems[index])
                                    : null;
                                CartPage.cartItems.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      choosenItems!.isEmpty
                          ? Colors.grey
                          : Theme.of(context).primaryColor),
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

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          AccountPage.isUserLogged() == false
              ? showDialog(
                  context: context,
                  builder: (context) => const AlertDialogUserCheck(
                      subText: "You should login to view your cart."),
                )
              : Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CartPage();
                    },
                  ),
                );
        });
      },
      icon: Icon(
        Icons.shopping_bag_outlined,
        color: Colors.grey.shade900,
      ),
    );
  }
}
