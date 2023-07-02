import 'package:flutter/material.dart';
import 'package:flutter_cardeal/components/text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "Manufacturer"),
          onFieldSubmitted: (value) {
            print(value);
          },
        ),
        actions: [
          //    IconButton(onPressed: () {showFilterDialog(context, minPriceController: minPriceController, maxPriceController: maxPriceController, minMilageController: minMilageController, maxMilageController: maxMilageController)}, icon: Icon(Icons.filter_alt_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.network(
                        "https://th.bing.com/th/id/OIP.E8TuL5TwMZekZCTec15iLAHaFj?w=225&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7",
                        width: MediaQuery.of(context).size.width / 2.7,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            "Wolksvagen Passat 2019 ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text("28000000 S.P")
                        ],
                      ),
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 13.5,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
            itemCount: 10),
      ),
    );
  }

  showFilterDialog(context,
      {required TextEditingController minPriceController,
      required TextEditingController maxPriceController,
      required TextEditingController minMilageController,
      required TextEditingController maxMilageController}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Column(
        children: [
          MyTextField().build(context,
              hint: "min price", controller: minPriceController),
          MyTextField().build(context,
              hint: "max price", controller: maxPriceController),
          MyTextField().build(context,
              hint: "min mileage", controller: minMilageController),
          MyTextField().build(context,
              hint: "max mileage", controller: maxMilageController),
          TextButton(onPressed: () {}, child: const Text("Search"))
        ],
      )),
    );
  }
}
