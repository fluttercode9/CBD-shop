import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:provider/provider.dart';

class CartItem {
  Product item;
  int quantity;
  CartItem({
    @required this.item,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(CartItem cartItem) {
    print('additem');
    if (_items.containsKey(cartItem.item.id)) {
      _items.update(
          cartItem.item.id,
          (existingCartItem) => CartItem(
                item: existingCartItem.item,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          cartItem.item.id, () => CartItem(item: cartItem.item, quantity: 1));
    }
    print('item added');
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    items.forEach((_, item) => total += item.item.price*item.quantity);
    return total;
  }
}
