import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/components/text_field.dart';
import 'package:flutter_cardeal/constants.dart';

import 'cubit/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchList = AppCubit().get(context).carSearch;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: TextFormField(
              autofocus: true,
              controller: searchController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Manufacturer"),
              onFieldSubmitted: (value) {
                AppCubit()
                    .get(context)
                    .searchCar(manufacturer: searchController.text);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showFilterDialog(
                      context,
                    );
                  },
                  icon: Icon(Icons.filter_alt_rounded))
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
                            "${searchList[index].imageUrl}",
                            width: MediaQuery.of(context).size.width / 2.7,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${searchList[index].make} ${searchList[index].model} ${searchList[index].year}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text("${searchList[index].price} \$")
                            ],
                          ),
                        ),
                      ],
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                itemCount: searchList.length),
          ),
        );
      },
    );
  }

  showFilterDialog(
    context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        var minPriceController = TextEditingController();
        var maxPriceController = TextEditingController();
        var minMileageController = TextEditingController();
        var maxMileageController = TextEditingController();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Dialog(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField().build(context,
                    hint: "min price", controller: minPriceController),
                MyTextField().build(context,
                    hint: "max price", controller: maxPriceController),
                MyTextField().build(context,
                    hint: "min mileage", controller: minMileageController),
                MyTextField().build(context,
                    hint: "max mileage", controller: maxMileageController),
                TextButton(
                    onPressed: () {
                      AppCubit().get(context).searchCar(
                          manufacturer: searchController.text,
                          minPrice: minPriceController.text,
                          maxPrice: maxPriceController.text,
                          minMileage: minMileageController.text,
                          maxMileage: maxMileageController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Search"))
              ],
            ));
          },
        );
      },
    );
  }
}
