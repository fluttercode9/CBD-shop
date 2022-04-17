import 'package:flutter/material.dart';
import '/providers/products.dart';
import 'package:provider/provider.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overwiew_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        title: 'CBD shop',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.deepPurple,
          
        ),
        home: ProductOverwiewScreen(),
        routes: {
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
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
