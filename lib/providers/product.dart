import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {@required this.price,
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      this.isFavorite = false});

}
