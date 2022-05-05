import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.route, arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            color: Colors.purple[200],
            onPressed: () {
              //checks if item already in cart -- if not then adds
              bool alreadyIn =
                  cart.items.values.any((element) => element.item == product);
              if (alreadyIn) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Produkt znajduje się już w koszyku',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                cart.addItem(
                  CartItem(
                    item: product,
                    quantity: 1,
                  ),
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${product.title} - dodano do koszyka'),
                  action: SnackBarAction(
                    label: 'Cofnij',
                    onPressed: () => cart.removeItem(product.id),
                  ),
                ));
              }
            },
            icon: Icon(Icons.shopping_cart),
          ),

          title: Text(
            product.title,
          ),
          backgroundColor: Colors.black45,
          subtitle: Text('${product.price} \$'),
          // trailing: IconButton(
          //   icon: Icon(Icons.favorite_border),
          //   onPressed: () {},
          //   alignment: Alignment.topRight,
          // ),

          // leading: IconButton(
          //   icon: Icon(Icons.shop),
          //   onPressed: () {},
          // ),
        ),
      ),
    );
  }
}
