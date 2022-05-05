import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/products_overwiew_screen.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Sklep'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Sklep'),
          onTap: () => {
            Navigator.of(context)
                .pushReplacementNamed(ProductOverwiewScreen.route)
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Zamówienia'),
          onTap: () =>
              {Navigator.of(context).pushReplacementNamed(OrdersScreen.route)},
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Produkty Panel'),
          onTap: () =>
              {Navigator.of(context).pushReplacementNamed(UserProductsScreen.route)},
        ),
      ],
    ));
  }
}
