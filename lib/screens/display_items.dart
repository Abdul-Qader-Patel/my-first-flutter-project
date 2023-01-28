import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/favourite_screen.dart';
import '../widgets/product_details.dart';
import 'Cart_items.dart';

class DisplayItems extends StatefulWidget {
  static List<Product> itemsData = [
    Product(
        id: "1",
        itemName: "T-shirt",
        price: 500,
        description: "A nice clothwear for summers. good stats for the cost",
        image: Image.asset(height: 400, width: 400, "assets/images/tshirt.jpg"),
        isFavourite: false),
    Product(
        id: "2",
        itemName: "Jeans",
        price: 750,
        description: "A nice jeans for any weather.",
        image: Image.asset(height: 300, width: 200, "assets/images/jeans.png"),
        isFavourite: false),
    Product(
        id: "3",
        itemName: "Goggles",
        price: 300,
        description: "Looks good on anybody, unless you wear it on spectacles.",
        image:
            Image.asset(height: 300, width: 200, "assets/images/goggles.png"),
        isFavourite: false),
    Product(
        id: "4",
        itemName: "Hoodie",
        price: 800,
        description: "Hoodie. Nothing else to say.",
        image: Image.asset(height: 300, width: 200, "assets/images/hoodie.png"),
        isFavourite: false),
    Product(
        id: "5",
        itemName: "Cap",
        price: 200,
        description:
            "Made from cotton, wear this headwear anytime be it summer or winter.",
        image: Image.asset(height: 300, width: 200, "assets/images/cap.png"),
        isFavourite: false),
    Product(
        id: "6",
        itemName: "Mask",
        price: 150,
        description: "Protect your jawline.",
        image: Image.asset(height: 300, width: 200, "assets/images/mask.png"),
        isFavourite: false),
    Product(
        id: "7",
        itemName: "Shorts",
        price: 400,
        description: "OG shorts from obibas.",
        image: Image.asset(height: 300, width: 200, "assets/images/shorts.png"),
        isFavourite: false),
    Product(
        id: "8",
        itemName: "Jacket",
        price: 1000,
        description:
            "Exclusively for winter wear unless you live in Antarctica.",
        image: Image.asset(
            fit: BoxFit.cover,
            height: 200,
            width: 200,
            "assets/images/jacket.png"),
        isFavourite: false),
  ];
  static int id = 8;

  const DisplayItems({super.key});

  @override
  State<DisplayItems> createState() => _DisplayItemsState();
}

int count = 0;

class _DisplayItemsState extends State<DisplayItems> {
  void changeFavourite(index) {
    setState(() {
      DisplayItems.itemsData[index].isFavourite =
          !DisplayItems.itemsData[index].isFavourite;
    });
    if (DisplayItems.itemsData[index].isFavourite == true) {
      setState(() {
        for (int i = 0; i < DisplayItems.itemsData.length; i++) {
          if (DisplayItems.itemsData[index].id == (i + 1).toString()) {
            Favourites.favouriteItems.add(DisplayItems.itemsData[i]);
            Favourites.favouriteList++;
          }
        }
      });
    }

    if (DisplayItems.itemsData[index].isFavourite == false) {
      setState(() {
        if (Favourites.favouriteItems.isNotEmpty) {
          for (int i = 0; i < Favourites.favouriteItems.length; i++) {
            if (DisplayItems.itemsData[index].id ==
                Favourites.favouriteItems[i].id) {
              Favourites.favouriteItems.removeAt(i);
              Favourites.favouriteList--;
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: const Text("Home")),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
              crossAxisCount: 2),
          itemCount: DisplayItems.itemsData.length,
          itemBuilder: (context, index) => GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.redAccent,
                  leading: GestureDetector(
                    onTap: () {
                      changeFavourite(index);
                    },
                    child: Icon(DisplayItems.itemsData[index].isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline),
                  ),
                  title: Container(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(DisplayItems.itemsData[index].itemName)),
                  trailing: GestureDetector(
                      onTap: () {
                        CartItems.totalPrice = 0;
                        setState(() {
                          CartItems.quantity[index] += 1;
                          for (int i = 0;
                              i < DisplayItems.itemsData.length;
                              i++) {
                            setState(() {
                              CartItems.totalPrice += CartItems.quantity[i] *
                                  DisplayItems.itemsData[i].price;
                            });
                          }
                        });
                      },
                      child: const Icon(Icons.shopping_cart)),
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              id: DisplayItems.itemsData[index].id,
                              itemName: DisplayItems.itemsData[index].itemName,
                              price: DisplayItems.itemsData[index].price,
                              description:
                                  DisplayItems.itemsData[index].description,
                              image: DisplayItems.itemsData[index].image,
                              isFavourite:
                                  DisplayItems.itemsData[index].isFavourite)));
                    },
                    child: DisplayItems.itemsData[index].image),
              )),
    );
  }
}
