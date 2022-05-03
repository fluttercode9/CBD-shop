import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import '../providers/orders.dart' as orders;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final orders.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd-MM-yyy  HH:MM').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: _isPressed ? Icon(Icons.expand_less) :Icon(Icons.expand_more),
            
                onPressed: () {
                  setState(() {
                    _isPressed = !_isPressed;
                  });
                }),
          ),
          if (_isPressed)
            Container(
              height: min(widget.order.products.length * 20.0 + 20, 180),
              child: ListView(
                children: 
                  widget.order.products.map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.item.title),
                        Text('${e.quantity} x ${e.item.price}')
                      ],
                    ),
                  ).toList(),
                
              ),
            )
        ],
      ),
    );
  }
}
