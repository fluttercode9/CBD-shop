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
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(CartItem cartItem) {
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
  }
}
