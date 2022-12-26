import 'package:shelf_mobil_frontend/models/book.dart';

class CartItem {
  Book bookItem;
  bool value;

  CartItem({required this.bookItem, this.value = false});

  @override
  operator ==(other) => other is CartItem && bookItem == other.bookItem;
  @override
  int get hashCode => Object.hash(bookItem, bookItem);
}
