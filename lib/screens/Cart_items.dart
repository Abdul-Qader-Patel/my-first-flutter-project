// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'display_items.dart';

class CartItems extends StatefulWidget {
  static List<int> quantity = [0, 0, 0, 0, 0, 0, 0, 0];
  static var totalPrice = 0;

  const CartItems({super.key});
  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: DisplayItems.itemsData.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: DisplayItems.itemsData[index].image,
                ),
                title: Text(DisplayItems.itemsData[index].itemName),
                subtitle: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          CartItems.totalPrice = 0;
                          CartItems.quantity[index]++;
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
                      child: const Icon(
                        Icons.add_circle_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text("Quantity: " + CartItems.quantity[index].toString()),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        if (CartItems.quantity[index] > 0) {
                          setState(() {
                            CartItems.totalPrice = 0;
                            CartItems.quantity[index]--;
                            for (int i = 0;
                                i < DisplayItems.itemsData.length;
                                i++) {
                              setState(() {
                                CartItems.totalPrice += CartItems.quantity[i] *
                                    DisplayItems.itemsData[i].price;
                              });
                            }
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                trailing: Text("Price: " +
                    (DisplayItems.itemsData[index].price *
                            CartItems.quantity[index])
                        .toString()),
              ),
            ),
          ),
          Container(
            color: Colors.lightGreen,
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                "Total: " + CartItems.totalPrice.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
