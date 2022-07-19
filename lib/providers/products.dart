import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:flutter_complete_guide/screens/products_overwiew_screen.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  Products(this.authToken, this.uid, this._items);
  final String authToken;
  final String uid;
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Aurora 22/1',
    //   description: 'Good aurora for gastrophase',
    //   price: 229.99,
    //   imageUrl:
    //       'https://www.stonerchef.pl/wp-content/uploads/2020/06/recenzja-aurora-pedanios-221.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Aurora 20/1',
    //   description: 'For sleep',
    //   price: 219.99,
    //   imageUrl:
    //       'https://www.stonerchef.pl/wp-content/uploads/2020/09/la-confidential-recenzja-odmiany-1280x960.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Red No.2',
    //   description: 'Pure energy',
    //   price: 199.99,
    //   imageUrl:
    //       'https://www.stonerchef.pl/wp-content/uploads/2019/11/dwa-topy-lemon-skunk-red-no-2-1024x768.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Aurora 8/8',
    //   description: 'A little CBD always good',
    //   price: 49.99,
    //   imageUrl:
    //       'https://cannabis-clinic.pl/wp-content/uploads/2022/01/cannabis_sativa_aurora_deutschland_equiposa_8_na_8_procent.jpg',
    //   isFavorite: true,
    // )
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favooriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchProductsFromFirebase() async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final res = await http.get(url);
      final Map<String, dynamic> extractedData = json.decode(res.body);
      _items = [];
      if (extractedData == null) {
        return;
      }
      final url_fav = Uri.parse(
          'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$uid.json?auth=$authToken');
      final res_fav = await http.get(url_fav);
      final fav_data = json.decode(res_fav.body);

      extractedData.forEach(
        (id, data) => _items.add(Product(
          id: id,
          description: data['description'],
          imageUrl: data['imageUrl'],
          price: data['price'],
          title: data['title'],
          isFavorite:fav_data ==null ? false : fav_data[id] ?? false,
        )),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }),
      );
      _items.add(product.copyWith(id: json.decode(res.body)['name']));
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> toggleFavorite(id) async {
    final product = findById(id);
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$uid/${id}.json?auth=$authToken');
    try {
      product.isFavorite = !product.isFavorite;

      final res = await http.put(
        url,
        body: json.encode(
          product.isFavorite,
        ),
      );
      if (res.statusCode >= 400) {
        throw HttpException('something went wrong!');
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteProduct(id) async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$authToken');
    try {
      final res = await http.delete(url);
      if (res.statusCode >= 400) {
        throw HttpException('Something went wrong :<');
      }
      _items.removeWhere((element) => element.id == id);
    } catch (err) {
      throw (err);
      // throw err;
    }
    notifyListeners();
  }

  void updateProduct(id, Product product) async {
    final url = Uri.parse(
        'https://shop-app-2bbe2-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }));
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = product;
    notifyListeners();
  }
}
