import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/text_field.dart';
import 'cubit/app_cubit.dart';

class SearchCarPart extends StatelessWidget {
  SearchCarPart({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: TextFormField(
              autofocus: true,
              controller: searchController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "name"),
              onFieldSubmitted: (value) {
                AppCubit()
                    .get(context)
                    .searchCarPart(name: searchController.text);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showFilterDialog(
                      context,
                    );
                  },
                  icon: const Icon(Icons.filter_alt_rounded))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            cubit.filter(0);
                          },
                          child: const Chip(label: Text("Exact matches"))),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            cubit.filter(1);
                          },
                          child: const Chip(label: Text("Start with matches"))),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            cubit.filter(2);
                          },
                          child: const Chip(label: Text("Suggested matches"))),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image.network(
                                    "${cubit.filterList[index].imageUrl}",
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset("assets/images/cardeal.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${cubit.filterList[index].name}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                          "${cubit.filterList[index].price} \$")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount: cubit.filterList.length),
                  ),
                ),
              ],
            ),
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
                TextButton(
                    onPressed: () {
                      AppCubit().get(context).searchCarPart(
                            name: searchController.text,
                            minPrice: minPriceController.text,
                            maxPrice: maxPriceController.text,
                          );
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
