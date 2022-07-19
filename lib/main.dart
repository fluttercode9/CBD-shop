import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import '/providers/orders.dart';
import '/screens/cart_screen.dart';
import '/providers/products.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overwiew_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(null, null, []),
            update: (ctx, auth, previousStateOfProducts) => Products(
                auth.token,
                auth.uid,
                previousStateOfProducts.items == null
                    ? previousStateOfProducts.items
                    : []), //tworzy nowy obiekt products dlatego jakby nie przekazac tamtej listy itemow to by znikla :(
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (ctx) => Orders(null, null),
              update: (ctx, auth, orders) => Orders(
                    auth.token,
                    auth.uid,
                  ))
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            title: 'CBD shop',
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              accentColor: Colors.deepPurple,
            ),
            home: auth.isLoggedIn ? ProductOverwiewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
              CartScreen.route: (ctx) => CartScreen(),
              OrdersScreen.route: (ctx) => OrdersScreen(),
              UserProductsScreen.route: (ctx) => UserProductsScreen(),
              EditProductScreen.route: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CBD Shop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
