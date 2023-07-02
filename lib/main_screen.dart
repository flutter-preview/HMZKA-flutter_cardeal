import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardeal/add_car_screen.dart';
import 'package:flutter_cardeal/categories_screen.dart';
import 'package:flutter_cardeal/favorites_screen.dart';
import 'package:flutter_cardeal/home_screen.dart';
import 'package:flutter_cardeal/profile_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  List screen = [
    const HomeScreen(),
    const CategoriesScreen(),
    AddCarScreen(),
    const FavoritesScreen(),
    const ProfileScreen()
  ];
  List buttons = [
    IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    const SizedBox(),
    IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
    const SizedBox()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Deal"),
        centerTitle: true,
        actions: [buttons[index]],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.car_detailed), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_sharp), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          ]),
      body: screen[index],
    );
  }
}
