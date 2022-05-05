import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/my_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('panel produktow'),
        ),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: products.items
              .map((e) => UserProductItem(e.imageUrl, e.title))
              .toList(),
        ));
  }
}
