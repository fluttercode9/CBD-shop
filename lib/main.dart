import 'package:flutter/material.dart';
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
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx)=> Orders())
      ],
      child: MaterialApp(
        title: 'CBD shop',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.deepPurple,
        ),
        home: ProductOverwiewScreen(),
        routes: {
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          CartScreen.route: (ctx) => CartScreen(),
          OrdersScreen.route: (ctx) => OrdersScreen(),
          UserProductsScreen.route: (ctx) => UserProductsScreen(),
          EditProductScreen.route: (ctx) => EditProductScreen(),
        },
      ),
    );
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
