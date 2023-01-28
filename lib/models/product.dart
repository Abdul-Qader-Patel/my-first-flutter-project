import 'package:flutter/cupertino.dart';

class Product {
  String id;
  String itemName;
  int price;
  String description;
  Image image;
  bool isFavourite;

  Product({
    required this.id,
    required this.itemName,
    required this.price,
    required this.description,
    required this.image,
    required this.isFavourite,
  });
}
