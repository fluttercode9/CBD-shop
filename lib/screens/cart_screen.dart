import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
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
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) {
              return item.CartItem(cart.items.values.toList()[i]);
            },
            itemCount: cart.items.length,
          )),
          SumBar(cart: cart),
        ],
      ),
    );
  }
}

class SumBar extends StatelessWidget {
  const SumBar({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.deepPurple, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      elevation: 5,
      shadowColor: Colors.purple,
      // margin: EdgeInsets.all(12),
      child: Container(
        color: Colors.deepPurple,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Suma: ${(cart.totalAmount).toStringAsFixed(2)} zł ',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                          cart.clear();
                    },
                    child: Text(
                      "DO KASY",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
