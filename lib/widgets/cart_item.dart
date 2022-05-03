import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' as ci;
import 'package:flutter_complete_guide/providers/product.dart';

class CartItem extends StatelessWidget {
  ci.CartItem item;
  CartItem(this.item);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(item.item.id);
      },
      key: ValueKey(item.item.id),
      background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 50,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 4)),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(
                  item.item.imageUrl,
                  height: 130,
                  width: 170,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  item.item.title,
                  style: TextStyle(fontSize: 19),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {cart.incrementQuantity(item.item.id);}, icon: Icon(Icons.arrow_upward)),
                    IconButton(
                        onPressed: () {cart.decrementQuantity(item.item.id);}, icon: Icon(Icons.arrow_downward)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        // visualDensity: VisualDensity(vertical: 4),
      ),
    );
  }
}
