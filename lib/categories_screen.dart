import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/category_details_screen.dart';
import 'package:flutter_cardeal/components/components.dart';

import 'cubit/app_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var categories = AppCubit().get(context).categories;
        return BuildCondition(
          condition: categories.isNotEmpty,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  pushNavigation(
                      context, CategoryDetailsScreen(title: categories[index]));
                  AppCubit()
                      .get(context)
                      .getCategoryDetail(category: categories[index]);
                },
                borderRadius: BorderRadius.circular(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.network(
                          "https://th.bing.com/th/id/OIP.2f_3Bjg8P-4zCFK_2c1u8QHaEo?w=290&h=181&c=7&r=0&o=5&dpr=1.1&pid=1.7",
                          // height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 2.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        categories[index],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ]),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
