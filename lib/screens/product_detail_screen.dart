import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/cart_badge.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    final providerProduct = Provider.of<Products>(
      context,
      // listen: false,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    final loadedProduct = providerProduct.findById(product.id);
    final auth = Provider.of<Auth>(context);
    final token = auth.token;
    final uid = auth.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        actions: [
          CartBadge(),
          IconButton(
              onPressed: (() =>
                  providerProduct.toggleFavorite(loadedProduct.id)),
              icon: loadedProduct.isFavorite == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          cart.addItemWithCheck(context, cart, product);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('${loadedProduct.price} zł'),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('${loadedProduct.description}'),
            ),
          ],
        ),
      ),
    );
  }
}
