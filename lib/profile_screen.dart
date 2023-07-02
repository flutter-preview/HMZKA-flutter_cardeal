import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/app_cache.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';

import 'car_details_screen.dart';
import 'components/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var myCars = AppCubit().get(context).myCars;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://th.bing.com/th/id/R.7b87218a34ce5cd9f6cb59ee78fb3e9e?rik=UTW4kuS%2b%2fT%2bdNA&riu=http%3a%2f%2fvignette2.wikia.nocookie.net%2fmafiagame%2fimages%2f2%2f23%2fUnknown_Person.png%2frevision%2flatest%2fscale-to-width-down%2f464%3fcb%3d20151119092211&ehk=VgKcVhhiQxAuqvkG%2b8mTd2v6Co6DYGjgWKn2kd0ok5w%3d&risl=&pid=ImgRaw&r=0"),
                  ),
                  Card(
                    color: Colors.grey.shade50,
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Name: ${CacheHelper.getData(key: "name")}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey.shade50,
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Email Address: ${CacheHelper.getData(key: "email")}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: BuildCondition(
                      condition: myCars.isNotEmpty,
                      builder: (context) => GridView.count(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        children: myCars.map((e) {
                          return GestureDetector(
                            onTap: () {
                              pushNavigation(
                                  context, CarDetailsScreen(model: e));
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/images/cardeal.png",
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      fit: BoxFit.cover,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    "${e.make}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("${e.model} ${e.year}"),
                                  Text(
                                    "${e.price}  S.P",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
