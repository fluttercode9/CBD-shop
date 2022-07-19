import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class OrderItem {
  final String id;
  final DateTime dateTime;
  final List<CartItem> products;
  final double amount;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  final String authToken;
  final String uid;
  Orders(this.authToken, this.uid);


  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrdersFromFirebase() async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/orders/$uid.json?auth=$authToken');
    final res = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(res.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                  item: Product(
                      price: e['item']['price'],
                      id: e['item']['id'],
                      title: e['item']['title'],
                      description: e['item']['description'],
                      imageUrl: e['item']['imageUrl']),
                  quantity: e['quantity']))
              .toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/orders/$uid.json?auth=$authToken');
    final timestamp = DateTime.now();
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'item': {
                      'id': timestamp.toIso8601String(),
                      'title': e.item.title,
                      'description': e.item.description,
                      'price': e.item.price,
                      'imageUrl': e.item.imageUrl
                    },
                    'quantity': e.quantity
                  })
              .toList()
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(res.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
    } catch (err) {}

    notifyListeners();
  }
}
