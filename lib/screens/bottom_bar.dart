//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import './favourite_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import './add_items.dart';
import 'Cart_items.dart';
import 'display_items.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  List<Widget> screenOptions = [
    DisplayItems(),
    AddItems(),
    CartItems(),
    Favourites(),
  ];

  void setPosition(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screenOptions[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: setPosition,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                backgroundColor: Colors.red,
                icon: Icon(
                  FluentSystemIcons.ic_fluent_home_regular,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  FluentSystemIcons.ic_fluent_home_filled,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
              label: "Add Items",
              backgroundColor: Colors.blue,
              icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular,
                  color: Colors.white),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled,
                  color: Colors.black),
            ),
            BottomNavigationBarItem(
                label: "Shopping Cart",
                backgroundColor: Colors.green,
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                activeIcon: Icon(Icons.add_shopping_cart_outlined,
                    color: Colors.black)),
            BottomNavigationBarItem(
              label: "Favourites",
              backgroundColor: Colors.orange,
              icon: Icon(FluentSystemIcons.ic_fluent_favorites_regular,
                  color: Colors.white),
              activeIcon: Icon(
                FluentSystemIcons.ic_fluent_favorites_filled,
                color: Colors.black,
              ),
            ),
          ]),
    );
  }
}
