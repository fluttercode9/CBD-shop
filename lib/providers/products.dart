import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/products_overwiew_screen.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Aurora 22/1',
      description: 'Good aurora for gastrophase',
      price: 229.99,
      imageUrl:
          'https://www.stonerchef.pl/wp-content/uploads/2020/06/recenzja-aurora-pedanios-221.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Aurora 20/1',
      description: 'For sleep',
      price: 219.99,
      imageUrl:
          'https://www.stonerchef.pl/wp-content/uploads/2020/09/la-confidential-recenzja-odmiany-1280x960.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red No.2',
      description: 'Pure energy',
      price: 199.99,
      imageUrl:
          'https://www.stonerchef.pl/wp-content/uploads/2019/11/dwa-topy-lemon-skunk-red-no-2-1024x768.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Aurora 8/8',
      description: 'A little CBD always good',
      price: 49.99,
      imageUrl:
          'https://cannabis-clinic.pl/wp-content/uploads/2022/01/cannabis_sativa_aurora_deutschland_equiposa_8_na_8_procent.jpg',
      isFavorite: true,
    )
  ];

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // } else
    return [..._items];
  }

  List<Product> get favooriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  // bool _showFavoritesOnly = false;
  // void setShowFavoritesOnly(filterOptions option) {
  //   option == filterOptions.All
  //       ? _showFavoritesOnly = false
  //       : _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void toggleFavorite(id) {
    findById(id).isFavorite = !findById(id).isFavorite;
    notifyListeners();
  }
  void deleteProduct(id){
    _items.removeWhere((element) => element.id == id);
    notifyListeners();

  }
  void updateProduct(id, Product product){
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = product;
    notifyListeners();
  }
}
