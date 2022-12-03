import 'package:flutter/material.dart';

import 'account_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY SHELF"),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(35),
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
          child: const Center()),
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
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const AccountPage();
                        },
                      ),
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
      icon: const Icon(Icons.shopping_bag_outlined),
    );
  }
}
