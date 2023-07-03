import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardeal/add_car_screen.dart';
import 'package:flutter_cardeal/app_cache.dart';
import 'package:flutter_cardeal/categories_screen.dart';
import 'package:flutter_cardeal/components/components.dart';
import 'package:flutter_cardeal/buy_reqeusts_screen.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';
import 'package:flutter_cardeal/home_screen.dart';
import 'package:flutter_cardeal/login_screen.dart';
import 'package:flutter_cardeal/profile_screen.dart';
import 'package:flutter_cardeal/search_carpart_screen.dart';
import 'package:flutter_cardeal/search_screen.dart';
import 'package:flutter_cardeal/sell_reqeusts_screen.dart';

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
    const BuyRequestScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    List buttons = [
      IconButton(
          onPressed: () {
            pushNavigation(context, SearchScreen());
          },
          icon: const Icon(Icons.search)),
      IconButton(
          onPressed: () {
            pushNavigation(context, SearchCarPart());
            AppCubit().get(context).filter(0);
          },
          icon: const Icon(Icons.search)),
      const SizedBox(),
      IconButton(
          onPressed: () {
            pushNavigation(context, const SellRequestsScreen());
            AppCubit().get(context).getSellRequest();
          },
          icon: const Icon(Icons.notifications)),
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          pushAndRemoveUntil(context, LoginScreen());
          CacheHelper.removeData();
        },
      )
    ];
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
