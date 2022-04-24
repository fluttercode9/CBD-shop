import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/widgets/cart_item.dart' as item;
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Koszyk"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Suma',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    cart.totalAmount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Do kasy",
                      style: TextStyle(color: Colors.purpleAccent),
                    )),
                
              ],
            ),
          ),
                    Expanded(
                    child: ListView.builder(
                  itemBuilder: (ctx, i) {
                    return item.CartItem(cart.items.values.toList()[i]);
                  },
                  itemCount: cart.items.length,
                  
                ))

        ],
      ),
      
    );
  }
}
