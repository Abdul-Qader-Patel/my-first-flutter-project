// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  String id;
  String itemName;
  int price;
  String description;
  Image image;
  bool isFavourite;

  ProductDetails({
    super.key,
    required this.id,
    required this.itemName,
    required this.price,
    required this.description,
    required this.image,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.yellow, title: Text(itemName)),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 300, width: double.infinity, child: image),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ID: $id",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Price: $price",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
