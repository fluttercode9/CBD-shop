import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
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
    final loadedProduct = providerProduct.findById(product.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        actions: [
          IconButton(
              onPressed: (() => providerProduct.toggleFavorite(loadedProduct.id)),
              icon: loadedProduct.isFavorite == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}
