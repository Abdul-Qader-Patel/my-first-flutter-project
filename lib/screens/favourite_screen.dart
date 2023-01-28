// ignore_for_file: list_remove_unrelated_type

import 'package:flutter/material.dart';
import '../models/product.dart';
import './display_items.dart';

class Favourites extends StatefulWidget {
  static List<Product> favouriteItems = [];
  const Favourites({super.key});
  static int favouriteList = 8;

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  void removeFavourite(count) {
    for (int i = 0; i <= Favourites.favouriteList; i++) {
      if (Favourites.favouriteItems[count].id == "${i + 1}") {
        setState(() {
          print(Favourites.favouriteList);
          Favourites.favouriteItems.removeAt(count);
          DisplayItems.itemsData[i].isFavourite = false;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Favourites"),
      ),
      body: Favourites.favouriteItems.isEmpty
          ? Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                        height: 200,
                        width: 200,
                        "assets/images/nofavourites.png"),
                  ),
                ),
                const Text("No Favourites added yet",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
              ],
            )
          : ListView.builder(
              itemCount: Favourites.favouriteItems.length,
              itemBuilder: (context, count) => Column(
                    children: [
                      Favourites.favouriteItems[count].image,
                      Container(
                        height: 50,
                        color: Colors.deepOrangeAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "Price: ${Favourites.favouriteItems[count].price}"),
                            Text(Favourites.favouriteItems[count].itemName),
                            GestureDetector(
                                onTap: () {
                                  removeFavourite(count);
                                },
                                child: const Icon(Icons.remove_circle)),
                          ],
                        ),
                      )
                    ],
                  )),
    );
  }
}
