import 'package:flutter/material.dart';
import '../providers/products.dart';
import './productItem.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavoritesOnly;
  ProductsGrid(this.showFavoritesOnly);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    var products =
        showFavoritesOnly ? productsData.favooriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 20),
      itemBuilder: (ctx, index) {
        return ProductItem(products[index]);
      },
      itemCount: products.length,
    );
  }
}
