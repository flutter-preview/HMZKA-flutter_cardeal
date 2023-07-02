import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/car_details_screen.dart';
import 'package:flutter_cardeal/components/components.dart';
import 'package:flutter_cardeal/constants.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cars = AppCubit().get(context).cars;
        return BuildCondition(
          condition: cars.isNotEmpty,
          builder: (context) => GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: cars.map((e) {
              return GestureDetector(
                onTap: () {
                  pushNavigation(context, CarDetailsScreen(model: e));
                },
                child: Card(
                  shadowColor: Colors.black87,
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Image.network(
                        "${e.imageUrl}",
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/images/cardeal.png",
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 5,
                          fit: BoxFit.cover,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "${e.make}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text("${e.model} ${e.year}"),
                      Text(
                        "${e.price?.split('.').first} \$",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
