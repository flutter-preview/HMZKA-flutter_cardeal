import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'car_details_screen.dart';
import 'components/components.dart';
import 'cubit/app_cubit.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(title),
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var carParts = AppCubit().get(context).categoryDetails;
          return BuildCondition(
            condition: state is AppGetCategoryDetailSuccessState,
            builder: (context) => GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              children: carParts.map((e) {
                return GestureDetector(
                  onTap: () {},
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
                          "${e.name}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${e.price} \$",
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
      ),
    );
  }
}
