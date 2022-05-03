import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/my_drawer.dart';
import 'package:flutter_complete_guide/widgets/order_item.dart';
import '/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const route = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Zamówienia'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return OrderItem(orders.orders[index]);
        },
        itemCount: orders.orders.length,
      ),
    );
  }
}
