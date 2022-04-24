import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  // int length;
  // CartBadge(this.length);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 1),
      padding: EdgeInsets.all(4),
      badgeColor: Theme.of(context).accentColor,
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        "${cart.items.length}",
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.route);
          }),
    );
  }
}
