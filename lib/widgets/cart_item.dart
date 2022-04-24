import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../providers/cart.dart' as ci;
import 'package:flutter_complete_guide/providers/product.dart';

class CartItem extends StatelessWidget {
  ci.CartItem item;
  CartItem(this.item);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.green[50],
        child: Row(

          children: [
            ClipRRect(
              
                borderRadius: BorderRadius.all(Radius.circular(9)),
                child: Image.network(item.item.imageUrl, width: 149, height: 149,)),
          ],
        ),
            // visualDensity: VisualDensity(vertical: 4),
      ),
    );
  }
}
