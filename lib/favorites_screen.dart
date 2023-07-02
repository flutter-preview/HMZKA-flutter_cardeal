import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  "https://th.bing.com/th/id/OIP.E8TuL5TwMZekZCTec15iLAHaFj?w=225&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7",
                  width: MediaQuery.of(context).size.width / 2.7,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Wolksvagen Passat 2019 ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text("28000000 S.P")
                  ],
                ),
              ),
              SizedBox(
                child: CircleAvatar(
                  radius: 13.5,
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
